import XCTest
import SimpleNetwork
@testable import SOMDataLayer

final class SOMDataLayerTests: XCTestCase {

    func testExample() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        XCTAssertEqual(SOMDataLayer().text, "Hello, World!")
        let sut = MarsMissionDataRepository()
        let photos = try await sut.getPhotosByMartinSol(for: .curiosity, on: 1000, for: nil, and: 1)
        XCTAssertEqual(photos.count, 25)

        let photos2 = try await sut.getPhotosByDate(for: .curiosity, at: "2019-6-3", for: nil, and: 1)
        XCTAssertEqual(photos2.count, 25)
    }


    func testExample2() async throws {
        let sut = MarsMissionDataRepository()
        let rover = try await sut.getInformation(for: .curiosity)
        XCTAssertEqual(rover.name, "Curiosity")
    }
}
