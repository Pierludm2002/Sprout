//
//  OpenToTagsModel.swift
//  bloom
//
//  Created by Eleonora Persico on 18/10/25.
//

import Foundation
internal import Combine


struct TagsOpenTo {
    var title: String
}

class OpenToTagsModel: ObservableObject {
    @Published var tags: [TagsOpenTo] = [
        TagsOpenTo(title: "Collaboration"),
        TagsOpenTo(title: "Networking"),
        TagsOpenTo(title: "Mentorship"),
        TagsOpenTo(title: "Skill sharing"),
        TagsOpenTo(title: "Feedback"),
        TagsOpenTo(title: "Opportunities"),
        TagsOpenTo(title: "Brainstorming"),
    ]
}
