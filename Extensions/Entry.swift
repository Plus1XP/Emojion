//
//  Entry.swift
//  Emojion
//
//  Created by Plus1XP on 10/05/2022.
//

import Foundation

extension Entry {
    
    static let MockEntry: Entry =
    {
        let mockEntry = Entry()
        mockEntry.id = UUID()
        mockEntry.timestamp = Date()
        mockEntry.event = "Interview"
        mockEntry.emojion = "😬"
        mockEntry.feeling = [3,4,2]
        mockEntry.rating = 2
        mockEntry.note = "Coffee helped my anxeity"
        return mockEntry
    }()
    
    static let EmptyEntry: Entry =
    {
        let emptyEntry = Entry()
        emptyEntry.id = UUID()
        emptyEntry.timestamp = Date()
        emptyEntry.event = ""
        emptyEntry.emojion = ""
        emptyEntry.feeling = [0,0,0]
        emptyEntry.rating = 0
        emptyEntry.note = ""
        return emptyEntry
    }()
    
//    static var TempEntry: Entry =
//    {
//        let tempEntry = Entry(context: PersistenceController.shared.container.viewContext)
//        tempEntry.id = UUID()
//        tempEntry.timestamp = Date()
//        tempEntry.event = ""
//        tempEntry.emojion = ""
//        tempEntry.feeling = [0,0,0]
//        tempEntry.rating = 0
//        tempEntry.note = ""
//        return tempEntry
//    }()
//    
//    static func backupEntry(originalEntry: Entry) -> Entry {
//        let clonedEntry = Entry(context: PersistenceController.shared.container.viewContext)
//        clonedEntry.id = originalEntry.id!
//        clonedEntry.timestamp = originalEntry.timestamp!
//        clonedEntry.event = originalEntry.event!
//        clonedEntry.emojion = originalEntry.emojion!
//        clonedEntry.feeling = originalEntry.feeling!
//        clonedEntry.rating = originalEntry.rating
//        clonedEntry.note = originalEntry.note!
//        return clonedEntry
//    }
//    
//    static func restoreEntry(originalEntry: Entry, clonedEntry: Entry) -> Entry {
//        originalEntry.id = clonedEntry.id
//        originalEntry.timestamp = clonedEntry.timestamp
//        originalEntry.event = clonedEntry.event
//        originalEntry.emojion = clonedEntry.emojion
//        originalEntry.feeling = clonedEntry.feeling
//        originalEntry.rating = clonedEntry.rating
//        originalEntry.note = clonedEntry.note
//        return originalEntry
//    }
//    
//    static func ClearTempEntry() -> () {
//        TempEntry.id = UUID()
//        TempEntry.timestamp = Date()
//        TempEntry.event = ""
//        TempEntry.emojion = ""
//        TempEntry.feeling = [0,0,0]
//        TempEntry.rating = 0
//        TempEntry.note = ""
//    }
}
