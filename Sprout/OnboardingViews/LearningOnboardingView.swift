//
//  LearningOnboardingView.swift
//  Sprout
//
//  Created by Eleonora Persico on 21/10/25.
//

import SwiftUI
import SwiftData

struct LearningOnboardingView: View {
    @State private var learningModel = LearningTags()
    @Binding var selectedTags: [String]
    
    let onNext: () -> Void
    let onBack: () -> Void
    
    var body: some View {
        ZStack {
            GreenBackgroundView().ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("What are you currently learning?")
                        .font(AppStyles.TextStyle.pageTitle)
                        .foregroundColor(.black)
                    
                    Text("Share up to 3 skills are you're working on improving.")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 28)
                .padding(.top, 20)
                
                ScrollView {
                    FlowLayout(spacing: 12, alignment: .leading) {
                        ForEach(learningModel.learning, id: \.title) { tag in
                            ButtonTagView(
                                title: tag.title,
                                isSelected: selectedTags.contains(tag.title)
                            ) {
                                toggleSelection(for: tag.title)
                            }
                        }
                    }
                    .padding(.horizontal, 28)
                    .padding(.top, 32)
                }
                
                Button(action: onNext) {
                    HStack {
                        Text("Continue")
                            .font(.system(size: 19, weight: .light))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .font(.system(size: 19, weight: .light))
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(red: 0.93, green: 1.00, blue: 0.53))
                    )
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 40)
                .disabled(selectedTags.isEmpty)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: onBack) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    private func toggleSelection(for tag: String) {
        if selectedTags.contains(tag) {
            selectedTags.removeAll { $0 == tag }
        } else if selectedTags.count < 3 {
            selectedTags.append(tag)
        }
    }
}


#Preview {
    LearningOnboardingView (
        selectedTags: .constant(["Swift"]),
        onNext: {},
        onBack: {}
    )

}

