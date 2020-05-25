//
//  UIImageLoader.swift
//  DiscontBankApp
//
//  Created by niv ben-porath on 25/05/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit


class UIImageLoader  {
    internal static let loader = UIImageLoader()
    
    
    private let imageLoader = ImageLoader(imageCache: ImageCache.shared, runningTasksCache: RunningTasksCache.shared)
    private var uuidMap = [UIImageView:UUID]()
    
    private var dispatchQueue = DispatchQueue(label: "com.nbpapps.UIImageLoader", attributes: .concurrent)

    private init() {}
    
    internal func load(_ url : URL, for imageView : UIImageView) {
        //1
        let token = imageLoader.loadImage(at: url) { (result) in
            //2
            defer{self.remove(imageView)}
            
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
            setToken(token, for: imageView)
        }
    }
    
    internal func cancel(for imageView : UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancelLoad(for: uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
    
    private func remove(_ imageView : UIImageView) {
        dispatchQueue.sync(flags: .barrier) {
            let _ = self.uuidMap.removeValue(forKey: imageView)
        }
    }
    
    private func setToken(_ token: UUID, for imageView: UIImageView) {
        dispatchQueue.sync(flags: .barrier) {
            uuidMap[imageView] = token
        }
    }
    
}

