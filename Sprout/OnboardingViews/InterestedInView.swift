//
//  InterestedInView.swift
//  Sprout
//
//  Created by Eleonora Persico on 21/10/25.
//

import SwiftUI
import SwiftData

struct InterestedInView: View {
    
    @StateObject private var interestModel = TagsInterestedIn()
    @State private var selectedInterests: Set<String> = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                GreenBackgroundView()
                
                VStack(spacing: 20) {
                    
                    BackButtonView()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    
                    Text("What are you interested in?")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                   
                    Text("Pick up to 3 of your main interests")
                        .fontWeight(.thin)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    ScrollView {
                        FlowLayout(spacing: 8, alignment:.center) {
                            ForEach(interestModel.tags, id: \.title) { interest in
                                ButtonTagView(
                                    title: interest.title,
                                    isSelected: selectedInterests.contains(interest.title)
                                )
                                .onTapGesture {
                                    toggleSelection(for: interest.title)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    
                    ContinueButtonView()
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                }
            }
        }
    }
    
    private func toggleSelection(for tag: String) {
        if selectedInterests.contains(tag) {
            selectedInterests.remove(tag)
        } else if selectedInterests.count < 3 {
            selectedInterests.insert(tag)
        }
    }
}

#Preview {
    InterestedInView()
}
