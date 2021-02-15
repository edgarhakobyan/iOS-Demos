//
//  Task.swift
//  ToDoApp
//
//  Created by Edgar on 07.02.21.
//

import Foundation

struct Task {
    let name: String
    let description: String?
    let location: Location?
    var date: Date?
    
    init(name: String, description: String? = nil, location: Location? = nil) {
        self.name = name
        self.description = description
        self.location = location
        self.date = Date()
    }
}

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.name == rhs.name &&
            lhs.description == rhs.description &&
            lhs.location == rhs.location
    }
}
