//
//  TaskManagerTests.swift
//  ToDoAppTests
//
//  Created by Edgar on 07.02.21.
//

import XCTest
@testable import ToDoApp

class TaskManagerTests: XCTestCase {
    var sut: TaskManager!

    override func setUpWithError() throws {
        sut = TaskManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testInitTaskManagerWithZeroTasks() {
        XCTAssertTrue(sut.tasksCount == 0)
    }
    
    func testInitTaskManagerWithZeroDoneTasks() {
        XCTAssertTrue(sut.doneTasksCount == 0)
    }
    
    func testAddTaskIncrementCount() {
        let task = Task(name: "Task")
        sut.add(task)
        
        XCTAssertTrue(sut.tasksCount == 1)
    }
    
    func testTaskAtIndexIsAddedTask() {
        let task = Task(name: "Task")
        sut.add(task)
        let returnedTask = sut.getTask(at: 0);
        
        XCTAssertEqual(task, returnedTask)
    }
    
    func testCheckedTaskRemovedFromTasks() {
        let task1 = Task(name: "Task 1")
        let task2 = Task(name: "Task 2")
        sut.add(task1)
        sut.add(task2)
        sut.checkTask(at: 0)
        
        XCTAssertEqual(sut.getTask(at: 0), task2)
    }
    
    func testDoneTaskReturnsCheckedTask() {
        let task1 = Task(name: "Task 1")
        sut.add(task1)
        sut.checkTask(at: 0)
        
        XCTAssertEqual(sut.doneTask(at: 0), task1)
    }
    
    func testRemoveAllTasksResultsCountBeZero() {
        let task1 = Task(name: "Task 1")
        let task2 = Task(name: "Task 2")
        sut.add(task1)
        sut.add(task2)
        sut.checkTask(at: 0)
        sut.removeAll()
        
        XCTAssertTrue(sut.tasksCount == 0)
        XCTAssertTrue(sut.doneTasksCount == 0)
    }
    
    func testAddSameObjectDoesntIncrementCount() {
        let task1 = Task(name: "Task 1")
        let task2 = Task(name: "Task 1")
        sut.add(task1)
        sut.add(task2)
        
        XCTAssertTrue(sut.tasksCount == 1)
    }

}
