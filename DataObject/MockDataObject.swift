//
//  MockDataObject.swift
//  Emojion
//
//  Created by Plus1XP on 06/05/2022.
//

import Foundation

struct MockDataObject: Identifiable {
    var id: UUID
    var timestamp: Date
    var event: String
    var emojion: String
    var feeling: [Int]
    var rating: Int64
    var note: String
    
    static let `entry` = Self(id: UUID(), timestamp: Date(), event: "Interview", emojion: "😬", feeling: [4,4,1], rating: 2, note: "Coffee calmed my nerves!")
    
    static let `empty` = Self(id: UUID(), timestamp: Date(), event: "", emojion: "", feeling: [0,0,0], rating: 0, note: "")
    
    static var `temp` = Self(id: UUID(), timestamp: Date(), event: "", emojion: "", feeling: [0,0,0], rating: 0, note: "")
    
    static func backupEntry(originalEntry: Entry) -> MockDataObject {
        var clonedEntry = MockDataObject.empty
        clonedEntry.id = originalEntry.id!
        clonedEntry.timestamp = originalEntry.timestamp!
        clonedEntry.event = originalEntry.event!
        clonedEntry.emojion = originalEntry.emojion!
        clonedEntry.feeling = originalEntry.feeling!
        clonedEntry.rating = originalEntry.rating
        clonedEntry.note = originalEntry.note!
        return clonedEntry
    }
    
    static func restoreEntry(originalEntry: Entry, clonedEntry: MockDataObject) -> Entry {
        originalEntry.id = clonedEntry.id
        originalEntry.timestamp = clonedEntry.timestamp
        originalEntry.event = clonedEntry.event
        originalEntry.emojion = clonedEntry.emojion
        originalEntry.feeling = clonedEntry.feeling
        originalEntry.rating = clonedEntry.rating
        originalEntry.note = clonedEntry.note
        return originalEntry
    }
}
