//
//  TaskTests.swift
//  ToDoAppTests
//
//  Created by Edgar on 07.02.21.
//

import XCTest
@testable import ToDoApp

class TaskTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitTaskWithName() {
        let task = Task(name: "Task")
        XCTAssertNotNil(task, "Task can't be nill")
    }
    
    func testInitTaskWithNameAndDescription() {
        let task = Task(name: "Task", description: "desc")
        XCTAssertNotNil(task, "Task can't be nill")
    }
    
    func testPropertiesAreSet() {
        let name = "Task"
        let desc = "desc"
        let task = Task(name: name, description: desc)
        XCTAssertEqual(task.name, name)
        XCTAssertEqual(task.description, desc)
    }
    
    func testDateWasSetInInit() {
        let task = Task(name: "Task", description: "desc")
        XCTAssertNotNil(task.date, "Task can't be nill")
    }
    
    func testWhenGivenLocationSetsLocation() {
        let location = Location(name: "Test")
        let task = Task(name: "Task", description: "desc", location: location)
        
        XCTAssertEqual(location, task.location)
    }

}
