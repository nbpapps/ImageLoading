//
//  File.swift
//  
//
//  Created by niv ben-porath on 26/05/2020.
//

import XCTest
@testable import ImageLoading

final class RunningTasksCacheTests: XCTestCase {

    
    func test_SetTaskForUuid_GetTheSameTask() {
        let cache = RunningTasksCache.shared
        let task = URLSessionDataTask()
        let uuid = UUID()
        cache.setRunningTask(task, for: uuid)
        
        let taskFromCache = cache.getTask(for: uuid)
        XCTAssertEqual(task, taskFromCache, "Both tasks should be the same")
    }
    
    func test_SetAndRemoveTask_ReturnsNil() {
        let cache = RunningTasksCache.shared
        let task = URLSessionDataTask()
        let uuid = UUID()
        
        cache.setRunningTask(task, for: uuid)
        cache.remove(uuid)
        
        let taskFromCache = cache.getTask(for: uuid)
        
        XCTAssertNil(taskFromCache, "task should be nil")
    }
    
//    func test_SetAndCancelTask_TaskShouldBeCanceled() {
//        let cache = RunningTasksCache.shared
//        let task = URLSessionDataTask()
//        let uuid = UUID()
//               
//        cache.setRunningTask(task, for: uuid)
//        cache.cancelTask(for: uuid)
//        
////        let taskState = task.state
//        //URLSessionTask.State.canceling.rawValue
//        XCTAssertEqual(task.state.rawValue, 2, "Task should be in canceled state")
//    }
//    
    
    static var allTests = [
        ("test_SetTaskForUuid_GetTheSameTask", test_SetTaskForUuid_GetTheSameTask),
        ("test_SetAndRemoveTask_ReturnsNil", test_SetAndRemoveTask_ReturnsNil),
//        ("test_SetAndCancelTask_TaskShouldBeCanceled", test_SetAndCancelTask_TaskShouldBeCanceled),


    ]
}
