//
//  InterestedInView.swift
//  Sprout
//
//  Created by Eleonora Persico on 21/10/25.
//

import SwiftUI

struct InterestedInView: View {
    @StateObject private var interestModel = TagsInterestedIn()
    @Binding var selectedInterests: [String]
    
    let onNext: () -> Void
    let onBack: () -> Void
    
    var body: some View {
        ZStack {
            GreenBackgroundView().ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("What are you interested in?")
                        .font(AppStyles.TextStyle.pageTitle)
                        .foregroundColor(.black)
                    
                    Text("Pick up to 6 of your main interests.")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 28)
                .padding(.top, 20)
                
                ScrollView {
                    FlowLayout(spacing: 12, alignment: .leading) {
                        ForEach(interestModel.tags, id: \.title) { tag in
                            ButtonTagView(
                                title: tag.title,
                                isSelected: selectedInterests.contains(tag.title)
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
                            .font(.system(size: 19, weight: .medium))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .font(.system(size: 19, weight: .medium))
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
                .disabled(selectedInterests.isEmpty)
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
        if selectedInterests.contains(tag) {
            selectedInterests.removeAll { $0 == tag }
        } else if selectedInterests.count < 6 {
            selectedInterests.append(tag)
        }
    }
}

     #Preview {
     InterestedInView(
     selectedInterests: .constant(["Swift", "iOS"]),
     onNext: {},
     onBack: {}
     )
     }

    
