//
//  LearningOnboardingModel.swift
//  Sprout
//
//  Created by Eleonora Persico on 21/10/25.
//

import Foundation
internal import Combine

struct LearningTagsModel {
    var title: String
}

class LearningTags : ObservableObject {
    @Published var learning : [LearningTagsModel] = [
        LearningTagsModel(title: "Web Development"),
        LearningTagsModel(title: "Machine Learning"),
        LearningTagsModel(title: "Data Analysis"),
        LearningTagsModel(title: "UX/UI Design"),
        LearningTagsModel(title: "Marketing Strategies"),
        LearningTagsModel(title: "App Development"),
        LearningTagsModel(title: "Fintech"),
    ]
    
}
