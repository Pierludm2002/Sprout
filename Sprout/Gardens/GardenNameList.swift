//
//  GardenNameList.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 22/10/25.
//

import SwiftUI

struct GardenNameList: View {
    let garden: Garden
    @State private var searchText = ""

    var filteredProfiles: [Profile] {
        if searchText.isEmpty {
            return garden.profiles
        } else {
            return garden.profiles.filter { $0.prefName.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        ZStack {
            GreenBackgroundView().ignoresSafeArea()
            
            List {
                ForEach(filteredProfiles) { profile in
                    Button {
                    } label: {
                        HStack(spacing: 12) {
                            Image(profile.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())

                            VStack(alignment: .leading, spacing: 4) {
                                Text(profile.prefName)
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.black)
                                
                                if !profile.occupation.isEmpty || !profile.company.isEmpty {
                                    Text("\(profile.occupation) @\(profile.company)")
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Spacer()
                        }
                        .padding(.vertical, 8)
                    }
                    .buttonStyle(.plain)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Who are you looking for?"
            )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(garden.title)
                        .font(.system(size: 20, weight: .bold))
                }
            }
        }
    }
}

#if DEBUG
extension GardenViewModel {
    static func preview() -> GardenViewModel {
        let vm = GardenViewModel(store: MockGardenStore())
        Task { await vm.load() }
        return vm
    }
}
#endif

#Preview("Names List") {
    NavigationStack {
        let vm = GardenViewModel.preview()
        GardenNameList(
            garden: vm.gardens.first ?? Garden(title: "Preview Garden", date: "Jan 1, 2025", profiles: [])
        )
    }
}
