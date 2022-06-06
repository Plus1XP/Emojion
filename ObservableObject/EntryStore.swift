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
    
    var wordList: [String] = ["sausage", "blubber", "pencil", "cloud", "moon", "water", "computer", "school", "network", "hammer", "walking", "violently", "mediocre", "literature", "chair", "two", "window", "cords", "musical", "zebra", "xylophone", "penguin", "home", "dog", "final", "ink", "teacher", "fun", "website", "banana", "uncle", "softly", "mega", "ten", "awesome", "attatch", "blue", "internet", "bottle", "tight", "zone", "tomato", "prison", "hydro", "cleaning", "telivision", "send", "frog", "cup", "book", "zooming", "falling", "evily", "gamer", "lid", "juice", "moniter", "captain", "bonding", "loudly", "thudding", "guitar", "shaving", "hair", "soccer", "water", "racket", "table", "late", "media", "desktop", "flipper", "club", "flying", "smooth", "monster", "purple", "guardian", "bold", "hyperlink", "presentation", "world", "national",   "comment", "element", "magic", "lion", "sand", "crust", "toast", "jam", "hunter", "forest", "foraging", "silently", "tawesomated", "joshing", "pong",]
    
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
    
    func fetchEntries2(_ sortDescriptor: NSSortDescriptor? = nil, _ predicate: NSPredicate? = nil) {
        let request = NSFetchRequest<Entry>(entityName: "Entry")
        if let sort = sortDescriptor {
            request.sortDescriptors = [sort]

        }
        if let predicate1 = predicate {
            request.predicate = predicate1
        }
        do {
            entries = try PersistenceController.shared.container.viewContext.fetch(request)
        } catch {
            print("Error fetching. \(error)")
        }
    }
    
    func entiresWithinDateRangePredicate(date: Date) -> NSPredicate {
        NSPredicate(format: "timestamp >= %@ && timestamp <= %@", Calendar.current.startOfDay(for: date) as CVarArg, Calendar.current.startOfDay(for: date + 86400) as CVarArg)
    }
    
    func entiresDesendingSortDescriptor() -> NSSortDescriptor {
        NSSortDescriptor(key: "timestamp", ascending: false)
    }
    
    func addMockEntries(numberOfEntries: Int) {        
        for _ in 1...numberOfEntries {
            let newEntry = Entry(context: PersistenceController.shared.container.viewContext)
            newEntry.id = generateUUID()
            newEntry.timestamp = generateCalendarDate()
            newEntry.event = generateEvent()
            newEntry.emojion = generateEmoji()
            newEntry.feeling = generateFeeling()
            newEntry.rating = generateRating()
            newEntry.note = generateNote()
            saveChanges()
        }
        fetchEntries()
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
    
    func deleteAllEntries() {
        for entry in entries {
            PersistenceController.shared.container.viewContext.delete(entry)
        }
        saveChanges()
    }
    
    func resetCoreData() {
          for i in 0...PersistenceController.shared.container.managedObjectModel.entities.count-1 {
              let entity = PersistenceController.shared.container.managedObjectModel.entities[i]

              do {
                  let query = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name!)
                  let deleterequest = NSBatchDeleteRequest(fetchRequest: query)
                  try PersistenceController.shared.container.viewContext.execute(deleterequest)
                  try PersistenceController.shared.container.viewContext.save()

              } catch let error as NSError {
                  print("Error: \(error.localizedDescription)")
                  abort()
              }
          }
        fetchEntries()
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
    
    func generateUUID() -> UUID {
        return UUID()
    }
    
    func generateCalendarDate() -> Date {
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        let day = Calendar.current.component(.day, from: Date())
        let hour = Calendar.current.component(.hour, from: Date())
        let minute = Calendar.current.component(.minute, from: Date())
        let second = Calendar.current.component(.second, from: Date())
        let calendar = Calendar(identifier: .iso8601)
        let components = DateComponents(year: year, month: Int.random(in: 1...month), day: Int.random(in: 1...day), hour: Int.random(in: 1...hour), minute: Int.random(in: 0...minute), second: Int.random(in: 0...second))
        return calendar.date(from: components).unsafelyUnwrapped
    }
    
    func generateEvent() -> String {
        return getRandomWord()
    }
    
    func generateEmoji() -> String {
        return String(UnicodeScalar(Array(0x1F600...0x1F637).randomElement()!)!)
    }
    
    func generateFeeling() -> [Int] {
        return [Int.random(in: 0...6), Int.random(in: 0...3), Int.random(in: 0...1)]
    }
    
    func generateRating() -> Int64 {
        return Int64.random(in: 0...4)
    }
    
    func generateNote() -> String {
        var note: String = ""
        for _ in 1...Int.random(in: 5...30) {
            note.append("\(getRandomWord()) ")
        }
        return note
    }
    
    func getRandomWord() -> String {
        let index: Int = Int.random(in: 0...97)
        return wordList[index]
    }
}
