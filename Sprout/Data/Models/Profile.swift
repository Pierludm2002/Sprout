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
    var socialImage: [String] // social media bages
    var socialLinks: [String: String] = [:]
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
        self.openTo = openTo
        self.interestedIn = interestedIn
        self.workingOn = workingOn
        self.iconName = iconName
    }
}
