//
//  SocialLinkModalView.swift
//  Sprout
//
//  Created by Eleonora Persico on 23/10/25.
//
import SwiftUI

struct SocialLinkView: View {
    @State private var linkedAccounts: [String: String] = [:]
    @Environment(\.dismiss) var dismiss
    
    @State private var linkedin = ""
    @State private var twitter = ""
    @State private var instagram = ""
    @State private var github = ""
    
    var body: some View {
        ZStack {
            GreenBackgroundView()
            .ignoresSafeArea()
            
            // Form with transparent background
            Form {
                Section(header: Text("Enter your social profiles")) {
                    TextField("Enter URL", text: $linkedin)
                    TextField("Enter URL", text: $twitter)
                    TextField("Enter URL", text: $instagram)
                    TextField("Enter URL", text: $github)
                }
            }
            .scrollContentBackground(.hidden) // This is the key!
        }
        .navigationTitle("Social Links")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    // Save non-empty links
                    var updated: [String: String] = [:]
                    if !linkedin.isEmpty { updated["LinkedIn"] = linkedin }
                    if !twitter.isEmpty { updated["Twitter"] = twitter }
                    if !instagram.isEmpty { updated["Instagram"] = instagram }
                    if !github.isEmpty { updated["GitHub"] = github }
                    linkedAccounts = updated
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SocialLinkView()
    }
}
