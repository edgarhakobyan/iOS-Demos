//
//  DetailViewModel.swift
//  MVVM-1
//
//  Created by Edgar on 30.01.21.
//

import Foundation

class DetailViewModel: DetailViewModelType {
    private var profile: Profile
    
    init(profile: Profile) {
        self.profile = profile
    }
    
    var description: String {
        return "\(profile.name) \(profile.surname) is \(profile.age) old"
    }
    
    var age: Box<String?> = Box(nil)
}
