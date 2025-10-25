//
//  ProfileViewModel.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 23/10/25.
//

import Foundation
internal import Combine
import UIKit

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var profile: Profile
    @Published var isEditing = false
    @Published var errorMessage: String?
    @Published var qrImage: UIImage?

    private let store: ProfileStore
    private var bag = Set<AnyCancellable>()
   

    private struct SharePayload: Codable {
        let id: String
        let name: String
        let company: String
        let openTo: [String]
        let interests: [String]
        let workingOn: [String]
    }

    private var shareString: String {
        let payload = SharePayload(
            id: profile.id.uuidString,
            name: profile.prefName,
            company: profile.company,
            openTo: profile.openTo,
            interests: profile.interestedIn,
            workingOn: profile.workingOn
        )
        let data = (try? JSONEncoder().encode(payload)) ?? Data(profile.prefName.utf8)
        return String(data: data, encoding: .utf8) ?? profile.prefName
    }

    func buildQR() {
        let generator = QRCodeGenerator()
        qrImage = generator.make(from: shareString)
    }

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
    }

    func load() {
        Task { await store.load() }
    }

    func startEditing() { isEditing = true }

    func saveChanges(_ draft: Profile) {
        Task {
            do {
                try await store.save(draft)
                isEditing = false
            } catch {
                errorMessage = "Could not save profile."
            }
        }
    }
}
