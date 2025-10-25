//
//  SocialLinkModalView.swift
//  Sprout
//
//  Created by Eleonora Persico on 23/10/25.
//
import SwiftUI

struct SocialLinkModalView: View {
    @State private var linkedAccounts: [String: String] = [:]
    @Environment(\.dismiss) var dismiss
    
    @State private var linkedin = ""
    @State private var twitter = ""
    @State private var instagram = ""
    @State private var github = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter your social profiles")) {
                    TextField("LinkedIn URL", text: $linkedin)
                    TextField("Twitter URL", text: $twitter)
                    TextField("Instagram URL", text: $instagram)
                    TextField("GitHub URL", text: $github)
                }
            }
            .navigationTitle("Social Links")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
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
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}


#Preview {
    SocialLinkModalView()
}
