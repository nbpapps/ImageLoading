import XCTest
@testable import ImageLoading

final class UuidForIVTests: XCTestCase {
    
    func test_GetImageWithoutUrl_NilResult() {
       
    }
    
    func test_UuidCacheSet_GetSameUuid() {
        let cache = UuidForImageViewCache.shared
        let imageView = UIImageView()
        let uuid = UUID()
        
        cache.setToken(uuid, for: imageView)
        
        let uuidFromCache = cache.getUuid(for: imageView)
        
        XCTAssertEqual(uuid, uuidFromCache, "Both UUIDs should be the same")
    }
    
    
    func test_GetUuidWithoutSetting_ReturnsNil() {
        let cache = UuidForImageViewCache.shared
        let imageView = UIImageView()

        let uuidFromCache = cache.getUuid(for: imageView)
        
        XCTAssertNil(uuidFromCache, "UUID should be nil")

    }
    

    static var allTests = [
        ("test_UuidCacheSet_GetSameUuid", test_UuidCacheSet_GetSameUuid),
        ("test_GetUuidWithoutSetting_ReturnsNil",test_GetUuidWithoutSetting_ReturnsNil)
    ]
}
