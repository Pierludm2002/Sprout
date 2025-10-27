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
                        .font(AppStyles.TextStyle.pageTitle)
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
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 28)
                        .padding(.top, 20)
                    }
                    
                    Spacer()
                    
                        
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
