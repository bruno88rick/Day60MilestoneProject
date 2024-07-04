//
//  UserWithCodingKeys.swift
//  Day60MilestoneProject
//
//  Created by Bruno Oliveira on 03/07/24.
//

import Foundation

struct UserWithCodingKeys: Codable {
    enum CodingKeys: String, CodingKey {
        case firstName = "first"
        case lastName = "last"
    }
    
    var firstName: String
    var lastName: String
}
