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
    @Binding var selectedOpenTo: [String]
    
    let onNext: () -> Void
    let onBack: (() -> Void)?
    
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
                                    isSelected: selectedOpenTo.contains(tag.title)
                                ) {
                                    toggleSelection(for: tag.title)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                        
                    ContinueButtonView(title: "Continue  →") {
                        onNext()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    .disabled(selectedOpenTo.isEmpty)
                }
            }
        }
    }
    
    private func toggleSelection(for tag: String) {
        if selectedOpenTo.contains(tag) {
            selectedOpenTo.removeAll { $0 == tag }
        } else if selectedOpenTo.count < 3 {
            selectedOpenTo.append(tag)
        }
    }
}

#Preview {
    OnBoardingTagView(
        selectedOpenTo: .constant(["Networking"]),
        onNext: {},
        onBack: nil
    )
}
