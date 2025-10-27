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
        
        
        let base: [Profile] = [
            .init(prefName: "Luna Park", occupation: "Product Designer", company: "Figma",
                  socialImage: ["instagram"],
                  openTo: ["Collaboration", "Networking"], interestedIn: ["UX/UI Design", "Prototyping"],
                  workingOn: ["UX/UI Design"],
                  iconName: "ge1"),

            .init(prefName: "Ethan Vale", occupation: "iOS Developer", company: "Apple Dev Academy",
                  socialImage: ["github"],
                  openTo: ["Mentorship", "Skill sharing"], interestedIn: ["Swift", "App Development"],
                  workingOn: ["App Development"],
                  iconName: "ge2"),

            .init(prefName: "Mila Reyes", occupation: "AI Researcher", company: "DeepVision Lab",
                  socialImage: ["github", "linkedin"],
                  openTo: ["Feedback", "Opportunities"], interestedIn: ["Machine Learning", "Ethical AI"],
                  workingOn: ["Machine Learning"],
                  iconName: "ge3"),

            .init(prefName: "Kai Tanaka", occupation: "Creative Technologist", company: "IDEO Tokyo",
                  socialImage: ["instagram"],
                  openTo: ["Collaboration", "Brainstorming"], interestedIn: ["AR/VR", "Interaction Design"],
                  workingOn: ["Interaction Design"],
                  iconName: "ge4"),

            .init(prefName: "Isla Moreno", occupation: "Marketing Strategist", company: "GrowthHaus",
                  socialImage: ["instagram"],
                  openTo: ["Networking", "Feedback"], interestedIn: ["Branding", "Digital Marketing"],
                  workingOn: ["Marketing Strategies"],
                  iconName: "ge5"),

            .init(prefName: "Noah Kim", occupation: "Frontend Engineer", company: "NextGen Studios",
                  socialImage: ["github"],
                  openTo: ["Skill sharing", "Collaboration"], interestedIn: ["React", "Animations"],
                  workingOn: ["Web Development"],
                  iconName: "ge6"),

            .init(prefName: "Clara Du", occupation: "Founder", company: "Alloy Labs",
                  socialImage: ["linkedin"],
                  openTo: ["Mentorship", "Opportunities"], interestedIn: ["Startups", "AI"],
                  workingOn: ["Startups"],
                  iconName: "ge7"),

            .init(prefName: "Leo Marquez", occupation: "Data Scientist", company: "Accenture",
                  socialImage: ["github"],
                  openTo: ["Collaboration", "Feedback"], interestedIn: ["Data Analysis", "Cloud"],
                  workingOn: ["Data Analysis"],
                  iconName: "ge8"),

            .init(prefName: "Ava Rinaldi", occupation: "App Developer", company: "ONDA",
                  socialImage: ["instagram"],
                  openTo: ["Networking", "Collaboration"], interestedIn: ["Fintech", "UX"],
                  workingOn: ["Fintech"],
                  iconName: "ge9"),

            .init(prefName: "Renée Laurent", occupation: "UX Researcher", company: "Sprout",
                  socialImage: ["linkedin"],
                  openTo: ["Brainstorming", "Skill sharing"], interestedIn: ["Human-Centered Design"],
                  workingOn: ["UX/UI Design"],
                  iconName: "ge10")
        ]
        
        let gardens: [Garden] = [
            Garden(title: "Daiquiri Challenge", date: "Jan 4, 2025", profiles: Array(base.prefix(3))),
            Garden(title: "WWDC 2025", date: "Jan 22, 2025", profiles: Array(base.prefix(6))),
            Garden(title: "iOS Meetup Italy", date: "Feb 7, 2024", profiles: Array(base.prefix(5))),
            Garden(title: "Naples iOS Lab",date: "Mar 22, 2025",  profiles: base)
        ]
        
        subject.send(gardens)
    }
    
    func add(_ garden: Garden) async throws { subject.send(subject.value + [garden]) }
    func update(_ garden: Garden) async throws {
        var arr = subject.value
        if let idx = arr.firstIndex(where: { $0.id == garden.id }) { arr[idx] = garden }
        subject.send(arr)
    }
    func delete(id: UUID) async throws { subject.send(subject.value.filter { $0.id != id }) }
}
