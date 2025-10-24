//
//  CardInfoView.swift
//  bloom
//
//  Created by Pourya Mazinani on 17/10/25.
//

import SwiftUI

struct CardInfoView: View {
    @Binding var preferredName: String
    @Binding var jobTitle: String
    @Binding var company: String

    let onNext: () -> Void
    let onBack: (() -> Void)?

    var body: some View {
        ZStack {
            GreenBackgroundView()
            
            VStack(spacing: 0) {
                
                Text("Hello, welcome! Tell us about yourself")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
               
                Form {
                    TextField("Preferred Name", text: $preferredName)
                        .listRowBackground(Color.clear)
                    
                    TextField("Job Title", text: $jobTitle)
                        .listRowBackground(Color.clear)
                    
                    TextField("Company", text: $company)
                        .listRowBackground(Color.clear)
                    
                    
                    Section {
                        ContinueButtonView(title: "Continue  →") {
                            print("Continue tapped")
                            onNext()
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
            }
        }
        .toolbar {
            if let onBack {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Back", action: onBack)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CardInfoView(
            preferredName: .constant(""),
            jobTitle: .constant(""),
            company: .constant(""),
            onNext: {},
            onBack: nil
        )
    }
}
