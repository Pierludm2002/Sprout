//
//  OnboardingViewModel.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 23/10/25.
//

import Foundation
internal import Combine

@MainActor
final class OnboardingViewModel: ObservableObject {
    @Published var name = ""
    @Published var occupation = ""
    @Published var company = ""
    @Published var interests: [String] = []
    @Published var openTo: [String] = []
    @Published var workingOn: [String] = []
    @Published var iconName = "ge1"

    private let profileStore: ProfileStore

    init(profileStore: ProfileStore) { self.profileStore = profileStore }

    var canContinue: Bool { !name.trimmingCharacters(in: .whitespaces).isEmpty }

    func complete() {
        let p = Profile(
            prefName: name,
            occupation: occupation,
            company: company,
            socialImage: ["instagram","github"],
            openTo: openTo,
            interestedIn: interests,
            workingOn: workingOn,
            iconName: iconName
        )
        Task { try? await profileStore.save(p) }
    }
}
