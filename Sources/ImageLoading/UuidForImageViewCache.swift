//
//  File.swift
//  
//
//  Created by niv ben-porath on 25/05/2020.
//

import UIKit

struct UuidForImageViewCache {
    static let shared = UuidForImageViewCache()

    private var cache = NSCache<UIImageView, NSString>()//UUID

    internal func setToken(_ token : UUID, for imageView : UIImageView) {
        cache.setObject(string(for: token), forKey: imageView)
    }
    
    internal func canCancel(for imageView : UIImageView) -> UUID? {
        if let uuid = cache.object(forKey: imageView) {
            cache.removeObject(forKey: imageView)
            return UUID(uuidString: uuid as String)
        }
        return nil
    }
    
    internal func remove(_ imageView : UIImageView) {
        cache.removeObject(forKey: imageView)
    }
    
    internal func getUuid(for imageView : UIImageView) -> UUID? {
        if let uuidString = cache.object(forKey: imageView) {
            return UUID(uuidString: uuidString as String)
        }
        return nil
    }
    

    
    private func string(for uuid : UUID) -> NSString {
        return NSString(string: uuid.uuidString)
    }
}

