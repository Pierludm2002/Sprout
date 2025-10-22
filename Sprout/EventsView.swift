//
//  EventsView.swift
//  Sprout
//
//  Created by Pierluigi De Meo on 17/10/25.
//

import SwiftUI

struct EventsView: View {
    
    let gardens = GardenMocks.gardens
    
    var body: some View {
        VStack {
            VStack(spacing: 12) {
                Text(gardens[0].title)
                    .font(AppStyles.TextStyle.pageTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                TagView(title: gardens[0].date)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("Participants")
                    .font(AppStyles.TextStyle.subtitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Divider()
                
                VStack(spacing: 8) {
                    List(gardens[0].profiles) { profile in
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
    EventsView()
}
