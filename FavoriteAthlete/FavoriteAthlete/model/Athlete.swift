//
//  Athlete.swift
//  FavoriteAthlete
//
//  Created by Edgar on 16.04.22.
//

import Foundation

struct Athlete {
    let name: String
    let age: UInt
    let league: String
    let team: String
    
    var description: String {
        return "\(name) is \(age) years old and plays for the \(team) in the \(league)."
    }
}
