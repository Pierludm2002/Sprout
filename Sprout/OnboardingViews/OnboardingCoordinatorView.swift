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
                        onNext: { withAnimation {step = .interestIn} },
                        onBack: { withAnimation { step = .cardInfo } }
                    )
                    
                case .interestIn:
                    InterestedInView(selectedInterests: $draft.interestedIn,
                                     onNext: {withAnimation {step = .workingOn}},
                                     onBack: { withAnimation {step = .openTo}}
                    )
                case .workingOn:
                    LearningOnboardingView(selectedTags: $draft.workingOn,
                                           onNext: { withAnimation {step = .photo}},
                                           onBack: {withAnimation{step = .interestIn}})
                    
                    
                case .photo:
                    PhotoOnboardingView(
                                        onNext: {
                                            finish()
                                            step = .done},
                                        onBack: {step = .workingOn})
                    
                    
                case .done:
                    ProfileView()
                    
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
    
    private func finish() {
        let profile = Profile(
            prefName: draft.name,
            occupation: draft.occupation,
            company: draft.company,
            socialImage: ["instagram","github"],
            openTo: draft.openTo,
            interestedIn: draft.interestedIn,
            workingOn: draft.workingOn,
            iconName: draft.pic == nil ?"DefaultProfilePic" : ""
        )
        
        profileVM.saveChanges(profile)
        
        onDone()
    }
    
    enum Step: Int {
        case cardInfo = 1
        case openTo = 2
        case interestIn = 3
        case workingOn = 4
        case photo = 5
        case done = 6
        var index: Int { rawValue }
    }
    
    struct Draft {
        var name: String = ""
        var occupation: String = ""
        var company: String = ""
        var openTo: [String] = []
        var interestedIn: [String] = []
        var workingOn: [String] = []
        var pic: Data?
    }
}
#Preview {
    // Preview needs the env object
    let vm = ProfileViewModel(store: LocalJSONProfileStore())
    return OnboardingCoordinatorView(onDone: {})
        .environmentObject(vm)
}
