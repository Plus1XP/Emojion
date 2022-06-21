//
//  EStore.swift
//  Emojion
//
//  Created by Plus1XP on 17/04/2022.
//

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
    
    func getSectionHeaders(entries: [Entry]) -> Dictionary <Date , [Entry]> {
        let empty: [Date: [Entry]] = [:]
         return entries.reduce(into: empty) { acc, cur in
             let components = Calendar.current.dateComponents([.year, .month, .day], from: cur.timestamp!)
             let date = Calendar.current.date(from: components)!
             let existing = acc[date] ?? []
             acc[date] = existing + [cur]
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

    func addTestFlightMockEntries() -> Void {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        let day = Calendar.current.component(.day, from: Date())
        
        for i in 1...(day - 1) {
            if i % 2 == 0 {
                addNewEntry(date: formatter.date(from: "\(i)/\(month)/\(year) 08:00")!, event: "Walk Dog", emojion: "😤", feeling: [0,1,0], rating: 1, note: "I love my dog but it was far to cold today.")
            }
            if i % 2 == 1 {
                addNewEntry(date: formatter.date(from: "\(i)/\(month)/\(year) 20:00")!, event: "Play Squash", emojion: "💪", feeling: [6,2,1], rating: 3, note: "Excercise makes me feel alive!")
                addNewEntry(date: formatter.date(from: "\(i)/\(month)/\(year) 15:00")!, event: "Learn to Code", emojion: "🤓", feeling: [6,2,0], rating: 2, note: "I must succeed at all costs..")
            }
            if i % 3 == 0 {
                addNewEntry(date: formatter.date(from: "\(i)/\(month)/\(year) 18:00")!, event: "Dance Class", emojion: "🤭", feeling: [4,5,0], rating: 4, note: "learning the forbidden dance was exciting!")
                addNewEntry(date: formatter.date(from: "\(i)/\(month)/\(year) 21:30")!, event: "Babysit", emojion: "🫠", feeling: [1,2,1], rating: 0, note: "Note to self, dont have kids.")
            }
        }
        addNewEntry(date: formatter.date(from: "\(day)/\(month)/\(year) 09:00")!, event: "comicon", emojion: "🤯", feeling: [6,0,1], rating: 0, note: "1 of a kind experience ruined by the smell...")
        addNewEntry(date: formatter.date(from: "\(day)/\(month)/\(year) 14:00")!, event: "Job Interview", emojion: "😬", feeling: [3,4,1], rating: 2, note: "Coffee helped my anxeity")
        addNewEntry(date: formatter.date(from: "\(day)/\(month)/\(year) 18:00")!, event: "Dinner Date", emojion: "🥰", feeling: [4,8,0], rating: 4, note: "Great way to end the day!")
    }
    
    func addRandomMockEntries(numberOfEntries: Int) {
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
    
    func addNewEntry(date: Date, event: String, emojion: String, feeling: [Int], rating: Int64, note: String) {
        let newEntry = Entry(context: PersistenceController.shared.container.viewContext)
        newEntry.id = UUID()
        newEntry.timestamp = date
        newEntry.event = event
        newEntry.emojion = emojion
        newEntry.feeling = feeling
        newEntry.rating = rating
        newEntry.note = note
        saveChanges()
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
        
        let randomMonth = Int.random(in: 1...month)
        
        let components = DateComponents(year: year, month: randomMonth, day: generateDayDate(currentDay: day, currentMonth: month, randomMonth: randomMonth), hour: Int.random(in: 1...hour), minute: Int.random(in: 0...minute), second: Int.random(in: 0...second))
        return calendar.date(from: components).unsafelyUnwrapped
    }
    
    func generateDayDate(currentDay: Int, currentMonth: Int, randomMonth: Int) -> Int {
        
        if currentMonth == randomMonth {
            return Int.random(in: 1...currentDay)
        } else {
            return Int.random(in: 1...28)
        }
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
    
    func getOldestEntryDate() -> String {
            let sortedDate = entries.sorted(by: {$0.timestamp?.compare($1.timestamp!) == .orderedAscending}).first!.timestamp!
            let dateformat = DateFormatter()
                   dateformat.dateFormat = "d MMM yyyy"
                   return dateformat.string(from: sortedDate)
    }
    
    func getNewestEntryDate() -> String {
            let sortedDate = entries.sorted(by: {$0.timestamp?.compare($1.timestamp!) == .orderedDescending}).first!.timestamp!
            let dateformat = DateFormatter()
                   dateformat.dateFormat = "d MMM yyyy"
                   return dateformat.string(from: sortedDate)
    }
    
    func getPrimaryStats() -> [String: Int] {
        var feelingDictionary: [String: Int] = ["Angry": 0, "Bad": 0, "Disgusted": 0, "Fearful": 0, "Happy": 0, "Sad": 0, "Surprised": 0]

        for entry in entries {
            if entry.feeling?.first == 0 {
                feelingDictionary["Angry"]! += 1
            }
            if entry.feeling?.first == 1 {
                feelingDictionary["Bad"]! += 1
            }
            if entry.feeling?.first == 2 {
                feelingDictionary["Disgusting"]! += 1
            }
            if entry.feeling?.first == 3 {
                feelingDictionary["Fearful"]! += 1
            }
            if entry.feeling?.first == 4 {
                feelingDictionary["Happy"]! += 1
            }
            if entry.feeling?.first == 5 {
                feelingDictionary["Sad"]! += 1
            }
            if entry.feeling?.first == 6 {
                feelingDictionary["Surprised"]! += 1
            }
            
        }
        return feelingDictionary
    }
    
    func getPrimaryStats() -> [(String, Int)] {
        var feelingDictionary: [(String, Int)] = [("Angry", 0), ("Bad", 0), ("Disgusted", 0), ("Fearful", 0), ("Happy", 0), ("Sad", 0), ("Surprised", 0)]

        for entry in entries {
            if entry.feeling?.first == 0 {
                feelingDictionary[0].1 += 1
            }
            if entry.feeling?.first == 1 {
                feelingDictionary[1].1 += 1
            }
            if entry.feeling?.first == 2 {
                feelingDictionary[2].1 += 1
            }
            if entry.feeling?.first == 3 {
                feelingDictionary[3].1 += 1
            }
            if entry.feeling?.first == 4 {
                feelingDictionary[4].1 += 1
            }
            if entry.feeling?.first == 5 {
                feelingDictionary[5].1 += 1
            }
            if entry.feeling?.first == 6 {
                feelingDictionary[6].1 += 1
            }
            
        }
        return feelingDictionary
    }
}
