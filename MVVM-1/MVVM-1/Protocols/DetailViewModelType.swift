//
//  DetailViewModelType.swift
//  MVVM-1
//
//  Created by Edgar on 30.01.21.
//

import Foundation

protocol DetailViewModelType {
    var description: String { get }
    var age: Box<String?> { get }
}
