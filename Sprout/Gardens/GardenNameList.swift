//
//  GardenNameList.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 22/10/25.
//

import SwiftUI

struct GardenNameList: View {
    let garden = GardenMocks.gardens.first!
    @State private var searchText = ""

    var filteredProfiles: [Profile] {
        if searchText.isEmpty {
            return garden.profiles
        } else {
            return garden.profiles.filter { $0.prefName.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredProfiles) { profile in
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
            .navigationTitle(garden.title)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Who are you looking for?"
            )
        }
    }
}

#Preview {
    GardenNameList()
}
