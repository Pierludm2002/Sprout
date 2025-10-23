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
            ZStack {
                GreenBackgroundView()
                
                VStack(spacing: 0) {
                    
                    Text("Hello, tell us something about you")
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
                        
                        TextField("Emoji Country Flag", text: $emojiFlag)
                            .listRowBackground(Color.clear)
                        
                        
                        Section {
                            VStack {
                                ContinueButtonView()
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
        }
    }
}

#Preview {
    CardInfoView()
}
