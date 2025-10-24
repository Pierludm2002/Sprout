//
//  LearningOnboardingView.swift
//  Sprout
//
//  Created by Eleonora Persico on 21/10/25.
//

import SwiftUI
import SwiftData
/*
struct LearningOnboardingView: View {
    
@State private var learningModel = LearningTags()
    @State private var selectedTags: Set<String> = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                GreenBackgroundView()
                
                VStack(spacing: 20) {
                    
                    if let onBack {
                        BackButtonView(action: onBack)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                    }
                    
                    
                    Text("What are you currently learning?")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                   
                    Text("Select up to 3 skills you're currently working on:")
                        .fontWeight(.thin)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                Spacer()
                    
                    ScrollView {
                        FlowLayout(spacing: 8, alignment: .leading) {
                            ForEach(learningModel.learning, id: \.title) { tag in
                                ButtonTagView(
                                    title: tag.title,
                                    isSelected: selectedTags.contains(tag.title)
                                )
                                .onTapGesture {
                                    toggleSelection(for: tag.title)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    
                    ContinueButtonView(title: "Continue  →") {
                      //  onNext() 
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }
    }
    
    private func toggleSelection(for tag: String) {
        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
        } else if selectedTags.count < 3 {
            selectedTags.insert(tag)
        }
    }
}


#Preview {
    LearningOnboardingView()
}
*/
