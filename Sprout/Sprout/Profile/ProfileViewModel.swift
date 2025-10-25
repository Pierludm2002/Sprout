//
//  ProfileViewModel.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 23/10/25.
//

import Foundation
internal import Combine

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var profile: Profile
    @Published var isEditing = false
    @Published var errorMessage: String?

    private let store: ProfileStore
    private var bag = Set<AnyCancellable>()

    init(store: ProfileStore) {
        self.store = store
        if let current = store.current() {
            self.profile = current
        } else {
            self.profile = Profile(prefName: "Your Name", iconName: "ge1")
        }

        store.currentProfilePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.profile = $0 }
            .store(in: &bag)
        
        Task{
            await store.load()
        }
    }

    func load() {
        Task { await store.load() }
    }

    func startEditing() { isEditing = true }

    func saveChanges(_ draft: Profile) {
        Task {
            do {
                try await store.save(draft)
                await MainActor.run {
                                self.profile = draft
                                self.isEditing = false
                            }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Could not save profile."
                }
            }
        }
    }
}
