import XCTest
@testable import ImageLoading

final class ImageLoadingTests: XCTestCase {
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct
//        // results.
//    }
    
    func test_GetImageWithoutUrl_NilResult() {
        let imageCache = ImageCache.shared
        let imageFromCache = imageCache.loadedImageFor(URL(string: "https://www.google.com")!)
        XCTAssertNil(imageFromCache, "Image should be nil")
    }
    
    func test_ImageCacheSet_GetSameImage() {
        let imageCache = ImageCache.shared
        let image = UIImage(systemName: "xmark")!
        let url = URL(string: "https://www.google.com")!
        imageCache.setLoadedImage(image, for: url)
        let loadedImage = imageCache.loadedImageFor(url)!
        
        XCTAssertEqual(image, loadedImage, "original image and loadedImage image are not the same")
    }
    
    
    

    static var allTests = [
        ("test_ImageCacheSet_GetSameImage", test_ImageCacheSet_GetSameImage),
        ("test_GetImageWithoutUrl_NilResult",test_GetImageWithoutUrl_NilResult)
    ]
}
