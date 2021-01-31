//
//  CellViewModel.swift
//  MVVM-1
//
//  Created by Edgar on 30.01.21.
//

import Foundation

class CellViewModel: TableViewCellViewModelType {
    private var profile: Profile
    
    init(profile: Profile) {
        self.profile = profile
    }
    
    var fullName: String {
        return "\(profile.name) \(profile.surname)"
    }
    
    var age: String {
        return "\(profile.age)"
    }
}
