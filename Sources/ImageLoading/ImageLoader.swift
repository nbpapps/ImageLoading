//
//  ImageLoader.swift
//  DiscontBankApp
//
//  Created by niv ben-porath on 25/05/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

typealias ImageLoadedHandler = (Result<UIImage,Error>) -> Void


protocol ImageLoading {
    func loadImage(at url : URL, with completion : @escaping ImageLoadedHandler) -> UUID?
    func cancelLoad(for uuid : UUID)
}

class ImageLoader : ImageLoading {
    
    private var imageCache : ImageCache
    private var runningTasksCache : RunningTasksCache
    
    init(imageCache : ImageCache,runningTasksCache : RunningTasksCache) {
        self.imageCache = imageCache
        self.runningTasksCache = runningTasksCache
    }
    
    internal func loadImage(at url : URL, with completion : @escaping ImageLoadedHandler) -> UUID? {
        
        //1
        if let image = loadedImageFor(url) {
            completion(.success(image))
            return nil
        }
        
        //2
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //3 when is code runs, the data task is completed. We need to remove this task from the dictionary
            defer {self.remove(uuid)}
            
            //4
            if let data = data, let image = UIImage(data: data) {
                self.setLoadedImage(image, for: url)
                completion(.success(image))
                return
            }
            
            //5
            guard let error = error else {
                //no image or error
                return
            }
            
            guard (error as NSError).code == NSURLErrorCancelled else {//if the error is due to the task being canceled, we don't need to call the handler
                completion(.failure(error))
                return
            }
            //the request was cancelled, no need to call the callback
            
        }
        
        task.resume()
        
        
        //6
        self.setTask(task, for: uuid)
        return uuid
    }
    
    
    internal func cancelLoad(for uuid : UUID) {
        runningTasksCache.cancelTask(for: uuid)
    }
    
    //MARK: - image cache access
    private func loadedImageFor(_ url: URL) -> UIImage? {
        imageCache.loadedImageFor(url)
    }
    
    private func setLoadedImage(_ image: UIImage, for url: URL) {
        imageCache.setLoadedImage(image, for: url)
    }
    
    //MARK: - running tasks cache access
    private func setTask(_ task : URLSessionDataTask, for uuid : UUID) {
        runningTasksCache.setRunningTask(task, for: uuid)
    }
    
    private func remove(_ uuid: UUID) {
        runningTasksCache.remove(uuid)
    }
    
}
