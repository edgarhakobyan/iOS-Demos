//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Edgar on 07.02.21.
//

import Foundation

class TaskManager {
    private var tasks: [Task] = []
    private var doneTasks: [Task] = []
    
    var tasksCount: Int {
        return tasks.count
    }
    var doneTasksCount: Int {
        return doneTasks.count
    }
    
    func add(_ task: Task) {
        if !tasks.contains(task) {
            tasks.append(task)
        }
    }
    
    func getTask(at index: Int) -> Task {
        return tasks[index];
    }
    
    func doneTask(at index: Int) -> Task {
        return doneTasks[index];
    }
    
    func checkTask(at index: Int) {
        let t = tasks.remove(at: index)
        doneTasks.append(t)
    }
    
    func removeAll() {
        tasks.removeAll()
        doneTasks.removeAll()
    }
}
