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
                    onNext: { withAnimation { step = .interestIn } },
                    onBack: { withAnimation { step = .cardInfo } }
                )
                
            case .interestIn:
                InterestedInView(
                    selectedInterests: $draft.interestedIn,
                    onNext: { withAnimation { step = .workingOn } },
                    onBack: { withAnimation { step = .openTo } }
                )
                
            case .workingOn:
                LearningOnboardingView(
                    selectedTags: $draft.workingOn,
                    onNext: {
                        withAnimation {
                            finish()
                            step = .done
                        }
                    },
                    onBack: { withAnimation { step = .interestIn } }
                )
                
            case .done:
                ProfileView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("\(step.index)/4")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    private func finish() {
        let profile = Profile(
            prefName: draft.name,
            occupation: draft.occupation,
            company: draft.company,
            socialImage: ["instagram", "github"],
            openTo: draft.openTo,
            interestedIn: draft.interestedIn,
            workingOn: draft.workingOn,
            iconName: "ge1"
        )
        
        profileVM.saveChanges(profile)
    }
    
    enum Step: Int {
        case cardInfo = 1
        case openTo = 2
        case interestIn = 3
        case workingOn = 4
        case done = 5
        var index: Int { rawValue }
    }
    
    struct Draft {
        var name: String = ""
        var occupation: String = ""
        var company: String = ""
        var openTo: [String] = []
        var interestedIn: [String] = []
        var workingOn: [String] = []
    }
}
#Preview {

    let vm = ProfileViewModel(store: LocalJSONProfileStore())
    return OnboardingCoordinatorView(onDone: {})
        .environmentObject(vm)
}
