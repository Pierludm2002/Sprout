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
     let onBack: (() -> Void)?
     
     var body: some View {
     ZStack {
     GreenBackgroundView()
     
     VStack(spacing: 20) {
     if let onBack {
     Button("Back", action: onBack)
     .frame(maxWidth: .infinity, alignment: .leading)
     .padding(.horizontal)
     }
     
     Text("What are you interested in?")
     .font(.largeTitle).bold()
     .frame(maxWidth: .infinity, alignment: .leading)
     .padding(.horizontal)
     
     Text("Pick up to 3 of your main interests")
     .fontWeight(.thin)
     .frame(maxWidth: .infinity, alignment: .leading)
     .padding(.horizontal)
     
     ScrollView {
     FlowLayout(spacing: 8, alignment: .leading) {
     
     ForEach(interestModel.tags, id: \.title) { tag in
                   ButtonTagView(
                   title: tag.title,
            isSelected: selectedInterests.contains(tag.title)
                 ) {
                    toggleSelection(for: tag.title)
               }
     }
     }
     .padding(.horizontal)
     }
     
     ContinueButtonView(title: "Continue  →") {
     onNext()
     }
     .disabled(selectedInterests.isEmpty)
     .padding(.bottom, 20)
     }
     }
     }
     
     private func toggleSelection(for tag: String) {
     if selectedInterests.contains(tag) {
     selectedInterests.removeAll { $0 == tag }
     } else if selectedInterests.count < 3 {
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

    
