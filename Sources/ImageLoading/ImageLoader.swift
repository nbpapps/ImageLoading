//
//  ImageLoader.swift
//  DiscontBankApp
//
//  Created by niv ben-porath on 25/05/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

class ImageLoader {
    private var loadedImages = [URL:UIImage]()
    private var runningRequests = [UUID : URLSessionDataTask]()
    private var dispatchQueue = DispatchQueue(label: "com.nbpapps.ImageLoader", attributes: .concurrent)
    
    typealias ImageLoadedHandler = (Result<UIImage,Error>) -> Void
    
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
            defer {self.remove(uuid) }
            
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
        dispatchQueue.sync(flags: .barrier) {
            runningRequests[uuid] = task
        }
        return uuid
    }
    
    
    internal func cancelLoad(for uuid : UUID) {
        dispatchQueue.sync(flags: .barrier) {
            runningRequests[uuid]?.cancel()
            runningRequests.removeValue(forKey: uuid)
        }
    }
    
    private func loadedImageFor(_ url: URL) -> UIImage? {
        return dispatchQueue.sync {
            return self.loadedImages[url]
        }
    }
    
    private func setLoadedImage(_ image: UIImage, for url: URL) {
        dispatchQueue.sync(flags: .barrier) {
            self.loadedImages[url] = image
        }
    }
    
    private func remove(_ uuid: UUID) {
        dispatchQueue.sync(flags: .barrier) {
            let _ = self.runningRequests.removeValue(forKey: uuid)
        }
    }
    
}
