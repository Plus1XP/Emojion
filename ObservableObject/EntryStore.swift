//
//  EStore.swift
//  Emojion
//
//  Created by Plus1XP on 17/04/2022.
//

import Foundation
import CoreData

class EntryStore: ObservableObject {
    
    @Published var entries: [Entry] = []
    
    init() {
        fetchEntries()
    }
    
    func fetchEntries() {
        let request = NSFetchRequest<Entry>(entityName: "Entry")
        let sort = NSSortDescriptor(key: "timestamp", ascending: false)
                request.sortDescriptors = [sort]
        do {
            entries = try PersistenceController.shared.container.viewContext.fetch(request)
        } catch {
            print("Error fetching. \(error)")
        }
    }
    
    func addNewEntry(event: String, emojion: String, feeling: [Int], rating: Int64, note: String) {
        let newEntry = Entry(context: PersistenceController.shared.container.viewContext)
        newEntry.id = UUID()
        newEntry.timestamp = Date()
        newEntry.event = event
        newEntry.emojion = emojion
        newEntry.feeling = feeling
        newEntry.rating = rating
        newEntry.note = note
        saveChanges()
    }
    
    func updateEntry(entry: Entry) {
//        let currentSurname = learner.surname ?? ""
//        let newSurname = currentSurname + "!"
//        learner.surname = newSurname
        saveChanges()
    }
    
    func deleteEntry(entry: Entry) {
        PersistenceController.shared.container.viewContext.delete(entry)
        saveChanges()
    }
    
    func deleteEntry(offsets: IndexSet) {
        offsets.map { entries[$0] }.forEach(PersistenceController.shared.container.viewContext.delete)
        saveChanges()
    }
    
    func saveChanges() {
        PersistenceController.shared.saveContext() { error in
            guard error == nil else {
                print("An error occurred while saving: \(error!)")
                return
            }
            self.fetchEntries()
        }
    }
}
