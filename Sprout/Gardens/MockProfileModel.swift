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
        .init(prefName: "Zhen", iconName: "ge9"),
        .init(prefName: "Thundering Rhino", iconName: "ge10"),
        .init(prefName: "Storming Ox", iconName: "ge11"),
        .init(prefName: "Croc", iconName: "ge12"),
        .init(prefName: "Flying Rhino", iconName: "ge13"),
        .init(prefName: "Chao", iconName: "ge14"),
        .init(prefName: "Yao", iconName: "ge15"),
        .init(prefName: "Gow", iconName: "ge16"),
        .init(prefName: "Shengqi", iconName: "ge17"),
        .init(prefName: "Kweng", iconName: "ge18"),
        .init(prefName: "Mugan", iconName: "ge19"),
        .init(prefName: "Elephant", iconName: "ge20"),
        .init(prefName: "Tai Lung", iconName: "ge1"),
        .init(prefName: "Shen", iconName: "ge2")
        
        
        
        
    ]

    static let gardens: [Garden] = [
        .init(title: "Kungfu Meetup", date: "Juanuary 12, 2025", profiles: profiles),
        .init(title: "WWDC 2025", date: "March 17, 2025", profiles: Array(profiles.prefix(8))),
        .init(title: "Codecon Italy", date: "April 25, 2025", profiles: Array(profiles.prefix(5)))
    ]
}
