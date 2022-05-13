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
}
