//
//  File.swift
//  
//
//  Created by niv ben-porath on 25/05/2020.
//

import Foundation

struct RunningTasksCache {
    static let shared = RunningTasksCache()

    private var runningTasksCache = NSCache<NSString, URLSessionDataTask>()

    
    internal func setRunningTask(_ task : URLSessionDataTask, for uuid : UUID) {
        runningTasksCache.setObject(task, forKey: string(for: uuid))
    }
    
    internal func cancelTask(for uuid : UUID) {
        let key = string(for: uuid)
        if let task = runningTasksCache.object(forKey: key) {
            task.cancel()
            runningTasksCache.removeObject(forKey: key)
        }
    }
    
    internal func remove(_ uuid : UUID) {
        runningTasksCache.removeObject(forKey: string(for: uuid))
    }
    
    private func string(for uuid : UUID) -> NSString {
        return NSString(string: uuid.uuidString)
    }
}
