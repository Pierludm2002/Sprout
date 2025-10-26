//
//  GardenViewModel.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 23/10/25.
//

import Foundation
internal import Combine

@MainActor
final class GardenViewModel: ObservableObject {
    @Published var gardens: [Garden] = []
    private let store: GardenStore
    private var bag = Set<AnyCancellable>()

    init(store: GardenStore) {
        self.store = store
        store.gardensPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.gardens = $0 }
            .store(in: &bag)
    }

    func load() {
        Task { await store.load() }
    }

    // UI helpers
    func addGarden(title: String, date: String, profiles: [Profile]) {
        Task { try? await store.add(Garden(title: title, date: date, profiles: profiles)) }
    }

    func updateGarden(_ garden: Garden) {
        Task { try? await store.update(garden) }
    }

    func deleteGarden(id: UUID) {
        Task { try? await store.delete(id: id) }
    }
}
