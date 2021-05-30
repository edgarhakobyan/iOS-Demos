//
//  UserProfile.swift
//  Networking
//
//  Created by Edgar on 03.05.21.
//

import Foundation

struct UserProfile {
    let id: Int?
    let name: String?
    let email: String?
    
    init(data: [String: Any]) {
        self.id = data["id"] as? Int
        self.name = data["name"] as? String
        self.email = data["email"] as? String
    }
}
