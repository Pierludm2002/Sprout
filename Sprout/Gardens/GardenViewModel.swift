//
//  GardenViewModel.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 23/10/25.
//

import Foundation
internal import Combine
import UIKit

@MainActor
final class GardenViewModel: ObservableObject {
    @Published var gardens: [Garden] = []
    @Published var qrImage: UIImage?

    private let store: GardenStore
    private var bag = Set<AnyCancellable>()
    private let qr = QRCodeGenerator()

    init(store: GardenStore) {
        self.store = store
        store.gardensPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.gardens = $0 }
            .store(in: &bag)
    }


    private struct SharePayload: Codable {
        let id: String
        let title: String
        let date: String
    }

    func buildQR(for garden: Garden) {
        let payload = SharePayload(
            id: garden.id.uuidString,
            title: garden.title,
            date: garden.date
        )
        let data = (try? JSONEncoder().encode(payload)) ?? Data(garden.title.utf8)
        let string = String(data: data, encoding: .utf8) ?? garden.title
        qrImage = qr.make(from: string)
    }

    func load() {
        Task { await store.load() }    }

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
