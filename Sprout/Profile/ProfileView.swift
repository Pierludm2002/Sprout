//
//  ProfileView.swift
//  Sprout
//
//  Created by Pierluigi De Meo on 18/10/25.
//

import SwiftUI

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    @State private var selectedTags: Set<String> = []
    
    var body: some View {
        ZStack {
            GreenBackgroundView().ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {

                    VStack(alignment: .leading, spacing: 16) {

                        Image("DefaultProfilePic")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 140, height: 140)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color.white, lineWidth: 0.5)
                            )
                            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(profileVM.profile.prefName)
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.black)
                            
                            HStack(spacing: 4) {
                                if !profileVM.profile.occupation.isEmpty {
                                    Text(profileVM.profile.occupation)
                                        .font(.system(size: 18, weight: .regular))
                                        .foregroundColor(.black.opacity(0.7))
                                }
                                
                                if !profileVM.profile.company.isEmpty {
                                    Text("@" + profileVM.profile.company)
                                        .font(.system(size: 18, weight: .regular))
                                        .foregroundColor(.black.opacity(0.7))
                                }
                            }
                        }
                        

                        HStack(spacing: 16) {
                            Button(action: {}) {
                                Image(systemName: "envelope")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "link")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "globe")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.top, 4)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 28)
                    .padding(.top, 20)
                    .padding(.bottom, 32)
                    

                    VStack(spacing: 28) {
                        ProfileSectionCard(
                            title: "Open to",
                            items: profileVM.profile.openTo
                        )
                        
                        ProfileSectionCard(
                            title: "Interested in",
                            items: profileVM.profile.interestedIn
                        )
                        
                        ProfileSectionCard(
                            title: "Working on",
                            items: profileVM.profile.workingOn
                        )
                    }
                    .padding(.horizontal, 28)
                    .padding(.bottom, 120)
                }
            }
        }
    }
}

// Other person's profile view
struct OtherProfileView: View {
    let profile: Profile
    
    var body: some View {
        NavigationStack {
            ZStack {
                GreenBackgroundView().ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                    
                        VStack(alignment: .leading, spacing: 16) {
                            Image("DefaultProfilePic")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color.white, lineWidth: 3)
                                )
                                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(profile.prefName)
                                    .font(.system(size: 36, weight: .bold))
                                    .foregroundColor(.black)
                                
                                HStack(spacing: 4) {
                                    if !profile.occupation.isEmpty {
                                        Text(profile.occupation)
                                            .font(.system(size: 18, weight: .regular))
                                            .foregroundColor(.black.opacity(0.7))
                                    }
                                    
                                    if !profile.company.isEmpty {
                                        Text(profile.company)
                                            .font(.system(size: 18, weight: .regular))
                                            .foregroundColor(.black.opacity(0.7))
                                    }
                                }
                            }
                            
                            HStack(spacing: 16) {
                                ForEach(profile.socialImage.prefix(3), id: \.self) { social in
                                    Button(action: {}) {
                                        Image(systemName: iconForSocial(social))
                                            .font(.system(size: 20))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            .padding(.top, 4)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 28)
                        .padding(.top, 20)
                        .padding(.bottom, 32)
                        
                        // Content sections
                        VStack(spacing: 28) {
                            if !profile.openTo.isEmpty {
                                ProfileSectionCard(
                                    title: "Open to",
                                    items: profile.openTo
                                )
                            }
                            
                            if !profile.interestedIn.isEmpty {
                                ProfileSectionCard(
                                    title: "Interested in",
                                    items: profile.interestedIn
                                )
                            }
                            
                            if !profile.workingOn.isEmpty {
                                ProfileSectionCard(
                                    title: "Working on",
                                    items: profile.workingOn
                                )
                            }
                        }
                        .padding(.horizontal, 28)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func iconForSocial(_ social: String) -> String {
        switch social.lowercased() {
        case "instagram": return "camera"
        case "linkedin": return "briefcase"
        case "github": return "chevron.left.forwardslash.chevron.right"
        case "twitter": return "bird"
        default: return "link"
        }
    }
}

struct ProfileSectionCard: View {
    let title: String
    let items: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
            
            if items.isEmpty {
                Text("No items yet")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.gray.opacity(0.6))
                    .padding(.leading, 4)
            } else {
                FlowLayout(spacing: 10, alignment: .leading) {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.black.opacity(0.8))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.6))
                            )
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview("ProfileView") {
    let vm = ProfileViewModel(store: LocalJSONProfileStore())
    vm.profile = Profile(
        prefName: "Ana Rodriguez",
        occupation: "iOS Developer",
        company: "@Apple Developer Academy",
        socialImage: ["instagram", "github"],
        openTo: ["Networking", "Collaboration"],
        interestedIn: ["Swift", "SwiftUI", "Design"],
        workingOn: ["Sprout", "Personal Projects"],
        iconName: "ge1"
    )
    return NavigationStack {
        ProfileView()
            .environmentObject(vm)
    }
}

#Preview("OtherProfileView") {
    let profile = Profile(
        prefName: "Luna Park",
        occupation: "Product Designer",
        company: "@Figma",
        socialImage: ["instagram"],
        openTo: ["Collaboration", "Networking"],
        interestedIn: ["UX/UI Design", "Prototyping"],
        workingOn: ["Design Systems"],
        iconName: "ge1"
    )
    return OtherProfileView(profile: profile)
}
