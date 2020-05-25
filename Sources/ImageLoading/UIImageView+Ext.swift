//
//  File.swift
//  
//
//  Created by niv ben-porath on 25/05/2020.
//

import UIKit

extension UIImageView {

    public func loadImage(at url : URL) {
        UIImageLoader.loader.load(url, for: self)
    }
    
    public func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}
