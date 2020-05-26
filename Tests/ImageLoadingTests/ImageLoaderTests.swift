import XCTest
@testable import ImageLoading

enum LoadError : Error, Equatable {
    case noImage
}

final class ImageLoaderTests: XCTestCase {

    func test_SetImageMock_GetSameImage() {
        let session = URLSessionMock()
        let loader = ImageLoader(imageCache: ImageCache.shared, runningTasksCache: RunningTasksCache.shared, session: session)
        
        let image = UIImage(systemName: "xmark")!
        let imageData = image.pngData()!
        let initialImage = UIImage(data: imageData)!
        
        session.data = imageData
        
        let url = URL(fileURLWithPath: "url")
        
        var loadedImage : UIImage?
        
        let _ = loader.loadImage(at: url) { (result) in
            loadedImage = try! result.get()
        }
        XCTAssertEqual(loadedImage!.size, initialImage.size, "same?")
    }
    
    func test_LoadImage_ReturnError() {
        let session = URLSessionMock()
        let loader = ImageLoader(imageCache: ImageCache.shared, runningTasksCache: RunningTasksCache.shared, session: session)
        
        let initialError = LoadError.noImage
        session.error = initialError
        
        let url = URL(fileURLWithPath: "url")
        var loadError : Error?
        let _ = loader.loadImage(at: url) { (result) in
            switch result {
            case .failure(let error):
                loadError = error
            case .success(_):
                break
            }
        }
        
        XCTAssertEqual(loadError?.localizedDescription, initialError.localizedDescription, "same?")
    }
    
    
    static var allTests = [
        ("test_SetImageMock_GetSameImage", test_SetImageMock_GetSameImage),
        ("test_LoadImage_ReturnError",test_LoadImage_ReturnError)
    ]
    
}
