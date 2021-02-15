//
//  DataProviderTests.swift
//  ToDoAppTests
//
//  Created by Edgar on 13.02.21.
//

import XCTest
@testable import ToDoApp

class DataProviderTests: XCTestCase {
    var sut: DataProvider!
    var tableView: UITableView!
    
    override func setUpWithError() throws {
        sut = DataProvider()
        sut.taskManager = TaskManager()
        tableView = UITableView()
        tableView.dataSource = sut
    }
    
    override func tearDownWithError() throws {
        tableView = nil
        sut = nil
    }
    
    func testNumberOfSectionsAreTwo() {
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func testNumberOfRowsInSectionZeroIsTaskCount() {
        sut.taskManager?.add(Task(name: "First Task"))
        var numberOfRows = tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, 1)
        
        sut.taskManager?.add(Task(name: "Second task"))
        tableView.reloadData()
        numberOfRows = tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, 2)
    }
    
    func testNumberOfRowsInSectionOneIsDoneTaskCount() {
        sut.taskManager?.add(Task(name: "First Task"))
        sut.taskManager?.add(Task(name: "Second task"))
        sut.taskManager?.checkTask(at: 0)
        var numberOfRows = tableView.numberOfRows(inSection: 1)
        XCTAssertEqual(numberOfRows, 1)
        
        sut.taskManager?.checkTask(at: 0)
        tableView.reloadData()
        numberOfRows = tableView.numberOfRows(inSection: 1)
        XCTAssertEqual(numberOfRows, 2)
    }
    
    func testCellAtIndexPathReturnsTaskCell() {
        sut.taskManager?.add(Task(name: "First Task"))
        tableView.reloadData()
        
        let taskCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(taskCell is TaskCell)
    }
}
