//
//  GardenViewModel.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 23/10/25.
//

import Foundation
internal import Combine
import UIKit
import CoreImage

@MainActor
final class GardenViewModel: ObservableObject {
    @Published var gardens: [Garden] = []
    @Published var activeEventId: UUID?

    // while this is non-nil, user can’t create another event
    @Published var createdGarden: Garden?
    @Published var createdGardenQR: UIImage?

    @Published var errorMessage: String?

    private let store: GardenStore
    private var bag = Set<AnyCancellable>()

    init(store: GardenStore) {
        self.store = store

        store.gardensPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.gardens = $0 }
            .store(in: &bag)

        // restore previously created event (so QR is available after relaunch)
        restoreCreatedGardenLockIfNeeded()
        loadActiveEvent()
    }


    func load() async {
        await store.load()
    }


    var canCreateNewEvent: Bool { createdGarden == nil }

    func createGarden(title: String, date: Date) async {
        guard canCreateNewEvent else { return }

        let df = DateFormatter()
        df.dateStyle = .medium
        let garden = Garden(
            title: title,
            date: df.string(from: date),
            profiles: []
        )

        do {
            try await store.add(garden) // persist in store
            createdGarden = garden
            createdGardenQR = makeQR(for: garden)
            persistCreatedGardenLock(garden) // keep across launches
        } catch {
            errorMessage = "Couldn't save event. Please try again."
            return
        }
    }

    func clearCreatedGardenLock() {
        createdGarden = nil
        createdGardenQR = nil
        removeCreatedGardenLock()
    }
    
    func joinEvent(_ garden: Garden) {
        activeEventId = garden.id
        UserDefaults.standard.set(garden.id.uuidString, forKey: "activeEventId")
    }

    func leaveEvent() {
        activeEventId = nil
        UserDefaults.standard.removeObject(forKey: "activeEventId")
    }

    func loadActiveEvent() {
        if let idString = UserDefaults.standard.string(forKey: "activeEventId"),
           let id = UUID(uuidString: idString) {
            activeEventId = id
        }
    }

    func addProfileToGarden(_ profile: Profile, gardenId: UUID) async {
        guard var garden = gardens.first(where: { $0.id == gardenId }) else { return }
        
        // Check if profile already exists
        if !garden.profiles.contains(where: { $0.id == profile.id }) {
            garden.profiles.append(profile)
            try? await updateGarden(garden)
        }
    }



    private func makeQR(for garden: Garden) -> UIImage? {
        let payload: [String: String] = [
            "type": "garden_invite",
            "id": garden.id.uuidString,
            "title": garden.title,
            "date": garden.date
        ]

        guard
            let data = try? JSONSerialization.data(withJSONObject: payload, options: []),
            let filter = CIFilter(name: "CIQRCodeGenerator")
        else { return nil }

        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("M", forKey: "inputCorrectionLevel")
        guard let ciImage = filter.outputImage else { return nil }

        let scaled = ciImage.transformed(by: CGAffineTransform(scaleX: 12, y: 12))

        let context = CIContext()
        guard let cgImage = context.createCGImage(scaled, from: scaled.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }

    private let lockKey = "created_garden_lock.json"

    private func persistCreatedGardenLock(_ garden: Garden) {
        if let data = try? JSONEncoder().encode(garden) {
            UserDefaults.standard.set(data, forKey: lockKey)
        }
    }

    private func restoreCreatedGardenLockIfNeeded() {
        guard
            let data = UserDefaults.standard.data(forKey: lockKey),
            let g = try? JSONDecoder().decode(Garden.self, from: data)
        else { return }
        createdGarden = g
        createdGardenQR = makeQR(for: g)
    }

    private func removeCreatedGardenLock() {
        UserDefaults.standard.removeObject(forKey: lockKey)
    }

    func addGarden(_ garden: Garden) async throws { try await store.add(garden) }
    func updateGarden(_ garden: Garden) async throws { try await store.update(garden) }
    func deleteGarden(id: UUID) async throws { try await store.delete(id: id) }
}
