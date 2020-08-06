//
//  PostData.swift
//  NewsSwiftUI
//
//  Created by Edgar on 8/7/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable  {
    var id: String {
        return objectID
    }
    let objectID: String
    let title: String
    let url: String?
    let points: Int
}
