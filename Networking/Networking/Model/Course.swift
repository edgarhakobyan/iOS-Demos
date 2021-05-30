//
//  Course.swift
//  Networking
//
//  Created by Edgar on 27.03.21.
//

import Foundation

struct Course: Decodable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
    
    init(json: [String: Any]) {
        self.id = json["id"] as? Int
        self.name = json["name"] as? String
        self.link = json["link"] as? String
        self.imageUrl = json["imageUrl"] as? String
        self.numberOfLessons = json["number_of_lessons"] as? Int
        self.numberOfTests = json["number_of_tests"] as? Int
    }
    
    static func getArray(from jsonArray: Any) -> [Course] {
        guard let jsonArray = jsonArray as? Array<[String: Any]> else { return []}
//        var courses: [Course] = []
//        for item in jsonArray {
//            let course = Course(json: item)
//            courses.append(course)
//        }
//        return courses
        return jsonArray.compactMap { Course(json: $0) }
    }
}
