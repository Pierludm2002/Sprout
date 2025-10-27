//
//  Profile.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 23/10/25.
//

import Foundation

struct Profile: Identifiable, Codable, Equatable {
    let id: UUID
    var prefName: String
    var occupation: String
    var company: String
    var socialImage: [String] // social media badges
    var socialLinks: [String: String]
    var openTo: [String]
    var interestedIn: [String]
    var workingOn: [String]
    var iconName: String // garden element
    
    init(
        id: UUID = UUID(),
        prefName: String,
        occupation: String = "",
        company: String = "",
        socialImage: [String] = [],
        socialLinks: [String: String] = [:],
        openTo: [String] = [],
        interestedIn: [String] = [],
        workingOn: [String] = [],
        iconName: String
    ) {
        self.id = id
        self.prefName = prefName
        self.occupation = occupation
        self.company = company
        self.socialImage = socialImage
        self.socialLinks = socialLinks
        self.openTo = openTo
        self.interestedIn = interestedIn
        self.workingOn = workingOn
        self.iconName = iconName
    }
    

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        prefName = try container.decode(String.self, forKey: .prefName)
        occupation = try container.decode(String.self, forKey: .occupation)
        company = try container.decode(String.self, forKey: .company)
        socialImage = try container.decode([String].self, forKey: .socialImage)
        // Decode socialLinks with default empty dict if not present
        socialLinks = try container.decodeIfPresent([String: String].self, forKey: .socialLinks) ?? [:]
        openTo = try container.decode([String].self, forKey: .openTo)
        interestedIn = try container.decode([String].self, forKey: .interestedIn)
        workingOn = try container.decode([String].self, forKey: .workingOn)
        iconName = try container.decode(String.self, forKey: .iconName)
    }
}
