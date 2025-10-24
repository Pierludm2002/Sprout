//
//  ProfileStore.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 23/10/25.
//

import Foundation
internal import Combine

protocol ProfileStore {
    var currentProfilePublisher: AnyPublisher<Profile, Never> { get }
    func load() async
    func save(_ profile: Profile) async throws
    func current() -> Profile?
}

final class LocalJSONProfileStore: ProfileStore {
    private let subject = CurrentValueSubject<Profile?, Never>(nil)
    var currentProfilePublisher: AnyPublisher<Profile, Never> {
        subject.compactMap { $0 }.eraseToAnyPublisher()
    }
    private let fileURL: URL = {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return docs.appendingPathComponent("profile.json")
    }()

    func current() -> Profile? { subject.value }

    func load() async {
        if let data = try? Data(contentsOf: fileURL),
           let p = try? JSONDecoder().decode(Profile.self, from: data) {
            subject.send(p)
        } else {
            subject.send(nil) // onboarding 
        }
    }

    func save(_ profile: Profile) async throws {
        let data = try JSONEncoder().encode(profile)
        try data.write(to: fileURL, options: .noFileProtection)
        subject.send(profile)
    }
}
