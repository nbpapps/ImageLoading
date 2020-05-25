//
//  File.swift
//  
//
//  Created by niv ben-porath on 25/05/2020.
//

import Foundation

struct DataTasksForUuidCache {
    static let shared = DataTasksForUuidCache()

    private var dataTasksForUuidCache = NSCache<NSString, URLSessionDataTask>()

    
    internal func setRunningTask(_ task : URLSessionDataTask, for uuid : UUID) {
        dataTasksForUuidCache.setObject(task, forKey: string(for: uuid))
    }
    
    internal func cancelTask(for uuid : UUID) {
        let key = string(for: uuid)
        if let task = dataTasksForUuidCache.object(forKey: key) {
            task.cancel()
            dataTasksForUuidCache.removeObject(forKey: key)
        }
    }
    
    internal func remove(_ uuid : UUID) {
        dataTasksForUuidCache.removeObject(forKey: string(for: uuid))
    }
    
    private func string(for uuid : UUID) -> NSString {
        return NSString(string: uuid.uuidString)
    }
}
