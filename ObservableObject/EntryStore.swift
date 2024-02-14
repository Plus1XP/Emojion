//
//  EntryStore.swift
//  Emojion
//
//  Created by Plus1XP on 17/04/2022.
//

import CoreData
import SwiftUI

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
    
    func deleteEntry(index: Int) {
        PersistenceController.shared.container.viewContext.delete(entries[index])
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
    
//    Returns 1 Jan 2000 if timeStamp is nil
    func getOldestEntryDate() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "d MMM yyyy"
        guard let sortedDate = entries.sorted(by: {$0.timestamp?.compare($1.timestamp!) == .orderedAscending}).first?.timestamp! else { return dateformat.date(from: "1 Jan 2000")!.description }
        
        return dateformat.string(from: sortedDate)
    }
    
//    Returns 1 Jan 2000 if timeStamp is nil
    func getNewestEntryDate() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "d MMM yyyy"
        guard let sortedDate = entries.sorted(by: {$0.timestamp?.compare($1.timestamp!) == .orderedDescending}).first?.timestamp! else { return dateformat.date(from: "1 Jan 2000")!.description }
        
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
    
    func getPrimaryStats2() -> [(String, Int)] {
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
    
//    func getPrimaryStats3() -> [FeelingData]{
//        var chartData = [FeelingData]()
////        var feelingDictionary: [(String, Int)] = [("Angry", 0), ("Bad", 0), ("Disgusted", 0), ("Fearful", 0), ("Happy", 0), ("Sad", 0), ("Surprised", 0)]
//        var count0 = 0
//        var count1 = 0
//        var count2 = 0
//        var count3 = 0
//        var count4 = 0
//        var count5 = 0
//        var count6 = 0
//
//        for entry in entries {
//            if entry.feeling?.first == 0 {
//                count0 += 1
//                chartData.removeAll(where: { $0.type == "Angry"})
//                chartData.append(FeelingData(type: "Angry", count: count0, color: Color.red, date: [entry.timestamp!]))
//            }
//            if entry.feeling?.first == 1 {
//                count1 += 1
//                chartData.removeAll(where: { $0.type == "Bad"})
//                chartData.append(FeelingData(type: "Bad", count: count1, color: Color.green, date: [entry.timestamp!]))
//            }
//            if entry.feeling?.first == 2 {
//                count2 += 1
//                chartData.removeAll(where: { $0.type == "Disgusted"})
//                chartData.append(FeelingData(type: "Disgusted", count: count2, color: Color.gray, date: [entry.timestamp!]))
//            }
//            if entry.feeling?.first == 3 {
//                count3 += 1
//                chartData.removeAll(where: { $0.type == "Fearful"})
//                chartData.append(FeelingData(type: "Fearful", count: count3, color: Color.orange, date: [entry.timestamp!]))
//            }
//            if entry.feeling?.first == 4 {
//                count4 += 1
//                chartData.removeAll(where: { $0.type == "Happy"})
//                chartData.append(FeelingData(type: "Happy", count: count4, color: Color.yellow, date: [entry.timestamp!]))
//            }
//            if entry.feeling?.first == 5 {
//                count5 += 1
//                chartData.removeAll(where: { $0.type == "Sad"})
//                chartData.append(FeelingData(type: "Sad", count: count5, color: Color.blue, date: [entry.timestamp!]))
//            }
//            if entry.feeling?.first == 6 {
//                count6 += 1
//                chartData.removeAll(where: { $0.type == "Surprised"})
//                chartData.append(FeelingData(type: "Surprised", count: count6, color: Color.purple, date: [entry.timestamp!]))
//            }
//            
//        }
//        return chartData.sorted()
//    }
    
//    func getPrimarySelectedFeelingName(feelingArray: [Int]) -> String {
//        if !feelingArray.isEmpty {
//            return feelingFinderStore.feeling[feelingArray[0]].name.capitalized
//        } else {
//            return ""
//        }
//    }
//
//    func getPrimarySelectedFeelingColor(feelingArray: [Int]) -> Color {
//        if !feelingArray.isEmpty {
//            return feelingFinderStore.feeling[feelingArray[0]].color
//        } else {
//            return Color.primary
//        }
//    }
}
