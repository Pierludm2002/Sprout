//
//  MockProfileModel.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 19/10/25.
//

import Foundation
import SwiftUI

struct Profile: Identifiable {
    let id: UUID = UUID()
    var prefName: String
   // var profilePic: Image = Image("DefaultProfilePic")
    let iconName: String
}

struct Garden {
    let id = UUID()
    let title: String
    let date: String
    var profiles: [Profile]
}


enum GardenMocks {
    static let profiles: [Profile] = [
        .init(prefName: "Ping Xiao Po", iconName: "ge1"),
        .init(prefName: "Shifu", iconName: "ge2"),
        .init(prefName: "Tigress", iconName: "ge3"),
        .init(prefName: "Viper", iconName: "ge4"),
        .init(prefName: "Monkey", iconName: "ge5"),
        .init(prefName: "Mantis", iconName: "ge6"),
        .init(prefName: "Crane", iconName: "ge7"),
        .init(prefName: "Oogway", iconName: "ge8"),
        .init(prefName: "Zhen", iconName: "ge9")
        
    ]

    static let gardens: [Garden] = [
        .init(title: "Kungfu Meetup", date: "Juanuary 12, 2025", profiles: profiles),
        .init(title: "WWDC 2025", date: "March 17, 2025", profiles: profiles),
        .init(title: "Codecon Italy", date: "April 25, 2025", profiles: profiles)
    ]
}
