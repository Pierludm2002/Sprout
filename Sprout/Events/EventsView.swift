//
//  EventsView.swift
//  Sprout
//
//  Created by Pierluigi De Meo on 17/10/25.
//

import SwiftUI

struct EventsView: View {
    
    let garden: Garden
    
    var body: some View {
        VStack {
            VStack(spacing: 12) {
                Text(garden.title)
                    .font(AppStyles.TextStyle.pageTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                TagView(title: garden.date)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("Participants")
                    .font(AppStyles.TextStyle.subtitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Divider()
                
                VStack(spacing: 8) {
                    List(garden.profiles) { profile in
                        Button{
                            print("Profilo \(profile.prefName)")
                        } label: {
                            HStack {
                                Image(profile.iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                   
                                Text(profile.prefName)
                                    .font(AppStyles.TextStyle.body)
                                    .padding(.horizontal)
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                        }
                        .buttonStyle(.plain)
                        .listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)

                }
            }
            .padding(.vertical)
        }
        .backgroundView()

    }
}

#Preview {
    let sampleProfiles = [
        Profile(prefName: "Ana", iconName: "ge1"),
        Profile(prefName: "Shifu", iconName: "ge2"),
        Profile(prefName: "Tigress", iconName: "ge3")
    ]
    let sampleGarden = Garden(title: "Preview Garden", date: "Jan 1, 2025", profiles: sampleProfiles)
    return NavigationStack {
        EventsView(garden: sampleGarden)
    }
}
