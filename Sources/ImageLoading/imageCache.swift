//
//  File.swift
//  
//
//  Created by niv ben-porath on 25/05/2020.
//

import UIKit

struct ImageCache {
    static let shared = ImageCache()

    private var imageCache = NSCache<NSString, UIImage>()

    internal func loadedImageFor(_ url: URL) -> UIImage? {
        return imageCache.object(forKey: string(for: url))
    }

    internal func setLoadedImage(_ image: UIImage, for url: URL) {
        imageCache.setObject(image, forKey: string(for: url))
    }
    
    private func string(for url : URL) -> NSString {
        return NSString(string: url.absoluteString)
    }
}
