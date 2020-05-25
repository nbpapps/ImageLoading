//
//  UIImageLoader.swift
//  DiscontBankApp
//
//  Created by niv ben-porath on 25/05/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

class UIImageLoader {
    static let loader = UIImageLoader()
    
    private let imageLoader = ImageLoader()
    private var uuidMap = [UIImageView:UUID]()
    
    private init() {}
    
    func load(_ url : URL, for imageView : UIImageView) {
        //1
        let token = imageLoader.loadImage(at: url) { (result) in
            //2
            defer{self.uuidMap.removeValue(forKey: imageView)}
            
            do {
                //3
                let image = try result.get()
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }catch{
                //handle error
                print(error)
            }
        }
        
        //4
        if let token = token {
            uuidMap[imageView] = token
        }
    }
    
    func cancel(for imageView : UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancelLoad(for: uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}
extension UIImageView {
    
    func loadImage(at url : URL) {
        UIImageLoader.loader.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}
