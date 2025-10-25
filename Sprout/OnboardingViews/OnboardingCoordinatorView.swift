//
//  OnboardingCoordinatorView.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 24/10/25.
//

import SwiftUI

struct OnboardingCoordinatorView: View {
    let onDone: () -> Void

    @EnvironmentObject private var profileVM: ProfileViewModel

    @State private var step: Step = .cardInfo
    @State private var draft = Draft()

    var body: some View {
        NavigationStack {
            Group {
                switch step {
                case .cardInfo:
                    CardInfoView(
                        preferredName: $draft.name,
                        jobTitle: $draft.occupation,
                        company: $draft.company,
                        onNext: { withAnimation { step = .openTo } },
                        onBack: nil
                    )

                case .openTo:
                    OnBoardingTagView(
                        selectedOpenTo: $draft.openTo,
                        onNext: { finish() },
                        onBack: { withAnimation { step = .cardInfo } }
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("\(step.index)/2")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
    private func finish() {
        let profile = Profile(
            prefName: draft.name,
            occupation: draft.occupation,
            company: draft.company,
            socialImage: ["instagram","github"],
            openTo: draft.openTo,
            interestedIn: [],
            workingOn: [],
            iconName: "DefautProfilePic"
        )

        // publish + persist via VM
        profileVM.saveChanges(profile)

        // tell RootSwitcherView to move to the main app
        onDone()
    }

    enum Step: Int {
        case cardInfo = 1
        case openTo = 2
        var index: Int { rawValue }
    }

    struct Draft {
        var name: String = ""
        var occupation: String = ""
        var company: String = ""
        var openTo: [String] = []
    }
}

#Preview {
    // Preview needs the env object
    let vm = ProfileViewModel(store: LocalJSONProfileStore())
    return OnboardingCoordinatorView(onDone: {})
        .environmentObject(vm)
}
