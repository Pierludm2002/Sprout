//
//  GardenStore.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 23/10/25.
//

import Foundation
internal import Combine

protocol GardenStore {
    var gardensPublisher: AnyPublisher<[Garden], Never> { get }
    func load() async
    // simple CRUD
    func add(_ garden: Garden) async throws
    func update(_ garden: Garden) async throws
    func delete(id: UUID) async throws
}

final class LocalJSONGardenStore: GardenStore {
    private let subject = CurrentValueSubject<[Garden], Never>([])
    var gardensPublisher: AnyPublisher<[Garden], Never> { subject.eraseToAnyPublisher() }

    private let fileURL: URL

    init(filename: String = "gardens.json") {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        self.fileURL = docs.appendingPathComponent(filename)
    }

    func load() async {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([Garden].self, from: data) {
            subject.send(decoded)
        } else {
            subject.send([])
            // try? await seedIfEmpty()
        }
    }

    func add(_ garden: Garden) async throws {
        var arr = subject.value
        arr.append(garden)
        try persist(arr)
    }

    func update(_ garden: Garden) async throws {
        var arr = subject.value
        if let idx = arr.firstIndex(where: { $0.id == garden.id }) {
            arr[idx] = garden
            try persist(arr)
        }
    }

    func delete(id: UUID) async throws {
        var arr = subject.value
        arr.removeAll { $0.id == id }
        try persist(arr)
    }


    
    private func persist(_ gardens: [Garden]) throws {
        let data = try JSONEncoder().encode(gardens)
        // atomic write
        try data.write(to: fileURL, options: .noFileProtection)
        subject.send(gardens)
    }

    func seedIfEmpty() async throws {
        guard subject.value.isEmpty else { return }
        let profiles: [Profile] = [
            .init(prefName: "Ping Xiao Po", occupation: "Guerriero Dragon", company: "@Jade Palace",
                  socialImage: ["instagram","github"], interestedIn: ["Swift"], iconName: "ge1"),
            .init(prefName: "Shifu", iconName: "ge2"),
            .init(prefName: "Tigress", iconName: "ge3"),
            .init(prefName: "Viper", iconName: "ge4"),
            .init(prefName: "Monkey", iconName: "ge5"),
            .init(prefName: "Mantis", iconName: "ge6"),
        ]
        try await add(Garden(title: "Kungfu Meetup", date: "Jan 12, 2025", profiles: profiles))
        try await add(Garden(title: "WWDC 2025",     date: "Mar 17, 2025", profiles: profiles))
        try await add(Garden(title: "Codecon Italy", date: "Apr 25, 2025", profiles: profiles))
    }
}

final class MockGardenStore: GardenStore {
    private let subject = CurrentValueSubject<[Garden], Never>([])
    var gardensPublisher: AnyPublisher<[Garden], Never> { subject.eraseToAnyPublisher() }

    func load() async {
        guard subject.value.isEmpty else { return }
        let profiles: [Profile] = [
            .init(prefName: "Ping Xiao Po", occupation: "Guerriero Dragon", company: "@Jade Palace",
                  socialImage: ["instagram","github"], interestedIn: ["Swift"], iconName: "ge1"),
            .init(prefName: "Shifu", iconName: "ge2"),
            .init(prefName: "Tigress", iconName: "ge3"),
            .init(prefName: "Viper", iconName: "ge4"),
            .init(prefName: "Monkey", iconName: "ge5"),
            .init(prefName: "Mantis", iconName: "ge6"),
        ]
        subject.send([
            Garden(title: "Daiquiri Challenge", date: "Jan 12, 2025", profiles: profiles),
            Garden(title: "WWDC 2025",     date: "Mar 17, 2025", profiles: profiles),
            Garden(title: "iOS Meetup Italy", date: "Apr 25, 2025", profiles: profiles)
        ])
    }

    func add(_ garden: Garden) async throws { subject.send(subject.value + [garden]) }
    func update(_ garden: Garden) async throws {
        var arr = subject.value
        if let idx = arr.firstIndex(where: { $0.id == garden.id }) { arr[idx] = garden }
        subject.send(arr)
    }
    func delete(id: UUID) async throws { subject.send(subject.value.filter { $0.id != id }) }
}
