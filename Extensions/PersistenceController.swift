//
//  PersistenceController.swift
//  Emojion
//
//  Created by nabbit on 14/07/2024.
//

import Foundation

// demo data
extension PersistenceController {
    
    var sampleEntry: Entry {
        let context = PersistenceController.preview.container.viewContext
        let entry = Entry(context: context)
        entry.id = UUID()
        entry.timestamp = Date()
        entry.event = "Coding"
        entry.emojion = "😕"
        entry.feeling = [1,1,1]
        entry.rating = 3
        entry.note = "Wow! Such hard..."
        return entry
    }
    var blankEntry: Entry {
        let context = PersistenceController.preview.container.viewContext
        let entry = Entry(context: context)
        entry.id = UUID()
        entry.timestamp = Date()
        entry.event = ""
        entry.emojion = ""
        entry.feeling = [0,0,0]
        entry.rating = 0
        entry.note = "0"
        return entry
    }
}
