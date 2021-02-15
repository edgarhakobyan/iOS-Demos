//
//  LocationTests.swift
//  ToDoAppTests
//
//  Created by Edgar on 07.02.21.
//

import XCTest
import CoreLocation
@testable import ToDoApp

class LocationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitLocationWithName() {
        let task = Location(name: "Location")
        XCTAssertNotNil(task, "Location can't be nill")
    }
    
    func testInitSetsCoordinates() {
        let coordinates = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let task = Location(name: "Location", coordinates: coordinates)
        
        XCTAssertEqual(task.coordinates?.latitude, coordinates.latitude)
        XCTAssertEqual(task.coordinates?.longitude, coordinates.longitude)
    }

}
