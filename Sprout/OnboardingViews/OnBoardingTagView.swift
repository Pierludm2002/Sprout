//
//  ContentView.swift
//  bloom
//
//  Created by Eleonora Persico on 16/10/25.
//

import SwiftUI
import SwiftData

struct OnBoardingTagView: View {
    
    @StateObject private var tagsModel = OpenToTagsModel()
    @State private var selectedTags: Set<String> = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                GreenBackgroundView()
                
                VStack(spacing: 20) {
                    
                    BackButtonView()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    
                    Text("What are you open to?")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                   
                    Text("Select up to 3 ways you'd like to connect today:")
                        .fontWeight(.thin)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                Spacer()
                    
                    ScrollView {
                        FlowLayout(spacing: 8, alignment: .leading) {
                            ForEach(tagsModel.tags, id: \.title) { tag in
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
                    
                    
                    ContinueButtonView()
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
    OnBoardingTagView()
}
