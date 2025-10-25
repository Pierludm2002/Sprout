//
//  File.swift
//  Sprout
//
//  Created by Eleonora Persico on 21/10/25.
//

import Foundation
internal import Combine

struct InterestedInTagModel {
    var title: String
}

class TagsInterestedIn: ObservableObject {
    @Published var tags: [InterestedInTagModel] = [
        InterestedInTagModel(title: "iOS development"),
        InterestedInTagModel(title: "UX/UI design"),
        InterestedInTagModel(title: "Startups"),
        InterestedInTagModel(title: "Machine Learning"),
        InterestedInTagModel(title: "Cloud"),
        InterestedInTagModel(title: "Data Analysis"),
        InterestedInTagModel(title: "Brainstorming"),
    ]
}
