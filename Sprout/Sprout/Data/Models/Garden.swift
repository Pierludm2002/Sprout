//
//  Garden.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 23/10/25.
//

import Foundation

struct Garden: Identifiable, Equatable, Codable {
    let id: UUID
    var title: String
    var date: String
    var profiles: [Profile]

    init(id: UUID = UUID(), title: String, date: String, profiles: [Profile]) {
        self.id = id
        self.title = title
        self.date = date
        self.profiles = profiles
    }
}
