//
//  Questions.swift
//  Quizzer
//
//  Created by Edgar on 5/26/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

import Foundation

struct Question {
    let text: String
    let answer: String
    
    init(q: String, a: String) {
        text = q
        answer = a
    }
}
