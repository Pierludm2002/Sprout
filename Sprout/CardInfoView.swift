//
//  CardInfoView.swift
//  bloom
//
//  Created by Pourya Mazinani on 17/10/25.
//

import SwiftUI

struct CardInfoView: View {
    @State private var preferredName = ""
    @State private var jobTitle = ""
    @State private var company = ""
    @State private var bio = ""
    @State private var emojiFlag = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Preferred Name", text: $preferredName)
                    TextField("Job Title", text: $jobTitle)
                    TextField("Company", text: $company)
                    
                    Section(header: Text("Bio")) {
                        TextEditor(text: $bio)
                            .frame(minHeight: 120)
                    }
                    
                    TextField("Emoji Country Flag", text: $emojiFlag)
                Section {
                    
                }
                Button(action: {
                    print("Continue button tapped!")
                }) {
                    Text("Continue")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .glassEffect(.clear)
                        .cornerRadius(12)
                }        .navigationTitle("Your Card Info")
                    .navigationBarTitleDisplayMode(.inline)
            }
                                // Make the button row clear to allow a custom background color later if needed
                                .backgroundView()
                            }
                       
                            .scrollContentBackground(.hidden) // Makes the default Form background transparent
                    
    }
                    }
//test
                
#Preview {
    CardInfoView()
}
