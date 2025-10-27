//
//  QRScanHandler.swift
//  Sprout
//
//  Created by Ana Karina Aramoni Ruiz on 26/10/25.
//

import Foundation

struct QRScanHandler {
    static func handleScan(
        _ code: String,
        gardenVM: GardenViewModel,
        profileVM: ProfileViewModel
    ) async -> ScanResult {
        guard let data = code.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let type = json["type"] as? String else {
            return .error("Invalid QR code")
        }
        
        switch type {
        case "profile":
            return await handleProfileScan(code, gardenVM: gardenVM)
        case "garden_invite":
            return await handleEventScan(code, gardenVM: gardenVM)
        default:
            return .error("Unknown QR code type")
        }
    }
    
    private static func handleProfileScan(
        _ code: String,
        gardenVM: GardenViewModel
    ) async -> ScanResult {
        guard let activeEventId = gardenVM.activeEventId else {
            return .error("You must join an event first to scan profiles")
        }
        
        guard let data = code.data(using: .utf8),
              let payload = try? JSONDecoder().decode(ProfileQRPayload.self, from: data) else {
            return .error("Invalid profile QR code")
        }
        
        let profile = Profile(
            id: UUID(uuidString: payload.id) ?? UUID(),
            prefName: payload.name,
            occupation: payload.occupation,
            company: payload.company,
            socialImage: payload.socialImage,
            openTo: payload.openTo,
            interestedIn: payload.interests,
            workingOn: payload.workingOn,
            iconName: payload.iconName
        )

        await gardenVM.addProfileToGarden(profile, gardenId: activeEventId)
        
        return .profileAdded(profile)
    }
    
    private static func handleEventScan(
        _ code: String,
        gardenVM: GardenViewModel
    ) async -> ScanResult {
        guard let data = code.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: String],
              let eventId = UUID(uuidString: json["id"] ?? ""),
              let title = json["title"],
              let date = json["date"] else {
            return .error("Invalid event QR code")
        }
        

        if let existingGarden = gardenVM.gardens.first(where: { $0.id == eventId }) {
            gardenVM.joinEvent(existingGarden)
            return .eventJoined(existingGarden)
        } else {
            let newGarden = Garden(
                id: eventId,
                title: title,
                date: date,
                profiles: []
            )
            try? await gardenVM.addGarden(newGarden)
            gardenVM.joinEvent(newGarden)
            return .eventJoined(newGarden)
        }
    }
}

enum ScanResult {
    case profileAdded(Profile)
    case eventJoined(Garden)
    case error(String)
}

struct ProfileQRPayload: Codable {
    let type: String
    let id: String
    let name: String
    let occupation: String
    let company: String
    let socialImage: [String]
    let openTo: [String]
    let interests: [String]
    let workingOn: [String]
    let iconName: String
}
