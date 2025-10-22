//
//  GardenNameList.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 22/10/25.
//

import SwiftUI

struct GardenNameList: View {
    let garden = GardenMocks.gardens.first!

    var body: some View {
        
        // TODO: SEARCH BAR
        
        
        List {
            ForEach(garden.profiles) { profile in
                HStack {
                    Image(profile.iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())

                    VStack(alignment: .leading) {
                        Text(profile.prefName)
                            .font(.headline)
                        
                        Text("Guerriero Dragon")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 6)
            }
        }
        .listStyle(.plain)
    }
}



#Preview {
    GardenNameList()
}
