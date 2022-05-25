//
//  EStore.swift
//  Emojion
//
//  Created by Plus1XP on 17/04/2022.
//

import Foundation
import CoreData

class EntryStore: ObservableObject {
    @Published var entries: [Entry]
    
    // Random Test Dates
    let canUseTestDates: Bool = false
    let calendar = Calendar(identifier: .gregorian)
    let components = DateComponents(year: 2022, month: Int.random(in: 01...04), day: Int.random(in: 01...28))
    
    init() {
        self.entries = []
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
    
    //    func fetchEntries() {
    //        let request = NSFetchRequest<Entry>(entityName: "Entry")
    //        let sort = NSSortDescriptor(key: "timestamp", ascending: false)
    //                request.sortDescriptors = [sort]
    //        do {
    //            entries = try PersistenceController.shared.container.viewContext.fetch(request)
    //        } catch {
    //            print("Error fetching. \(error)")
    //        }
    //    }
    //
    //    static var PersonalResults: NSFetchRequest<TokenData> {
    //        let request: NSFetchRequest<TokenData> = TokenData.fetchRequest()
    //        request.predicate = NSPredicate(format: "displayGroup == %@", TokenGroupType.Personal.rawValue)
    //        request.sortDescriptors = [NSSortDescriptor(key: "indexNumber", ascending: true)]
    //
    //        return request
    //    }
    //
    //    @FetchRequest(
    //        entity: Entry.entity(),
    //        sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: false)],
    //        animation: .default) var entries: FetchedResults<Entry>
    
//    _entries = FetchRequest<Entry>(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: false)],
//                                 predicate: NSPredicate(
//                                    format: "timestamp >= %@ && timestamp <= %@",
//                                    Calendar.current.startOfDay(for: date.wrappedValue) as CVarArg,
//                                    Calendar.current.startOfDay(for: date.wrappedValue + 86400) as CVarArg))
    
    func addNewEntry(event: String, emojion: String, feeling: [Int], rating: Int64, note: String) {
        let newEntry = Entry(context: PersistenceController.shared.container.viewContext)
        newEntry.id = UUID()
        newEntry.timestamp = canUseTestDates ? calendar.date(from: components) : Date()
        newEntry.event = event
        newEntry.emojion = emojion
        newEntry.feeling = feeling
        newEntry.rating = rating
        newEntry.note = note
        saveChanges()
    }
    
    func updateEntry(entry: Entry) {
//        entry.updated = Date()
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
    
    func discardChanges() {
        PersistenceController.shared.container.viewContext.rollback()
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
