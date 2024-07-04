//
//  UserCustomCodableStrategy.swift
//  Day60MilestoneProject
//
//  Created by Bruno Oliveira on 04/07/24.
//

import Foundation

struct UserCustomCodableStrategy: Codable {
    enum CodingKeys: String, CodingKey {
        case firstName = "first"
        case lastName = "last"
        case age
    }
    
    var firstName: String
    var lastName: String
    var age: Int
    
    //Handle the struct to different data types -> Age - String on JSON but Int on Swift Struct
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        let stringAge = try container.decode(String.self, forKey: .age)
        self.age = Int(stringAge) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.firstName, forKey: .firstName)
        try container.encode(self.lastName, forKey: .lastName)
        try container.encode(String(self.age), forKey: .age)
    }
    
}
