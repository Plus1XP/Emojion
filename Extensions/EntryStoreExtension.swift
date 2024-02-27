//
//  EntryStoreExtension.swift
//  Emojion
//
//  Created by nabbit on 07/01/2024.
//

import Foundation

extension EntryStore {
    
    func addTestFlightMockEntries() -> Void {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        let day = Calendar.current.component(.day, from: Date())
        
        for i in 1...(day - 1) {
            if i % 2 == 0 {
                addNewEntry(date: formatter.date(from: "\(i)/\(month)/\(year) 08:00")!, event: "Walk Dog", emojion: "😤", feeling: [1,1,0], rating: 1, note: "I love my dog but it was far to cold today.")
            }
            if i % 2 == 1 {
                addNewEntry(date: formatter.date(from: "\(i)/\(month)/\(year) 20:00")!, event: "Play Squash", emojion: "💪", feeling: [7,2,1], rating: 3, note: "Excercise makes me feel alive!")
                addNewEntry(date: formatter.date(from: "\(i)/\(month)/\(year) 15:00")!, event: "Learn to Code", emojion: "🤓", feeling: [7,2,0], rating: 2, note: "I must succeed at all costs..")
            }
            if i % 3 == 0 {
                addNewEntry(date: formatter.date(from: "\(i)/\(month)/\(year) 18:00")!, event: "Dance Class", emojion: "🤭", feeling: [5,5,0], rating: 4, note: "learning the forbidden dance was exciting!")
                addNewEntry(date: formatter.date(from: "\(i)/\(month)/\(year) 21:30")!, event: "Babysit", emojion: "🫠", feeling: [2,2,1], rating: 0, note: "Note to self, dont have kids.")
            }
        }
        addNewEntry(date: formatter.date(from: "\(day)/\(month)/\(year) 09:00")!, event: "comicon", emojion: "🤯", feeling: [7,0,1], rating: 0, note: "1 of a kind experience ruined by the smell...")
        addNewEntry(date: formatter.date(from: "\(day)/\(month)/\(year) 14:00")!, event: "Job Interview", emojion: "😬", feeling: [4,4,1], rating: 2, note: "Coffee helped my anxeity")
        addNewEntry(date: formatter.date(from: "\(day)/\(month)/\(year) 18:00")!, event: "Dinner Date", emojion: "🥰", feeling: [5,8,0], rating: 4, note: "Great way to end the day!")
    }
    
    func addChartMockEntries() -> Void {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        let day = Calendar.current.component(.day, from: Date())
        
        for i in 1...(day - 1) {
            if i % 2 == 0 {
                addNewEntry(date: formatter.date(from: "\(i)/\(month)/\(year) 08:00")!, event: "Walk Dog", emojion: "😤", feeling: [1,1,0], rating: 1, note: "I love my dog but it was far to cold today.")
            }
            if i % 2 == 1 {
                addNewEntry(date: formatter.date(from: "\(i)/\(month)/\(year) 20:00")!, event: "Play Squash", emojion: "💪", feeling: [7,2,1], rating: 3, note: "Excercise makes me feel alive!")
                addNewEntry(date: formatter.date(from: "\(i)/\(month)/\(year) 15:00")!, event: "Learn to Code", emojion: "🤓", feeling: [7,2,0], rating: 2, note: "I must succeed at all costs..")
            }
            if i % 3 == 0 {
                addNewEntry(date: formatter.date(from: "\(i)/\(month)/\(year) 18:00")!, event: "Dance Class", emojion: "🤭", feeling: [5,5,0], rating: 4, note: "learning the forbidden dance was exciting!")
                addNewEntry(date: formatter.date(from: "\(i)/\(month)/\(year) 21:30")!, event: "Babysit", emojion: "🫠", feeling: [2,2,1], rating: 0, note: "Note to self, dont have kids.")
            }
        }
        addNewEntry(date: formatter.date(from: "\(day)/\(month)/\(year) 09:00")!, event: "comicon", emojion: "🤯", feeling: [7,0,1], rating: 0, note: "1 of a kind experience ruined by the smell...")
        addNewEntry(date: formatter.date(from: "\(day)/\(month)/\(year) 14:00")!, event: "Job Interview", emojion: "😬", feeling: [4,4,1], rating: 2, note: "Coffee helped my anxeity")
        addNewEntry(date: formatter.date(from: "\(day)/\(month)/\(year) 18:00")!, event: "Dinner Date", emojion: "🥰", feeling: [5,8,0], rating: 4, note: "Great way to end the day!")
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
    
    func addAllMockFeelings() -> Void {
        addAngryFeelingMockEntries()
        addBadFeelingMockEntries()
        addDisgustedFeelingMockEntries()
        addFearfulFeelingMockEntries()
        addHappyFeelingMockEntries()
        addSadFeelingMockEntries()
        addSurprisedFeelingMockEntries()
        fetchEntries()
    }
    
    func addAngryFeelingMockEntries() {
        var primary = 0
        var secondary = 0
        var tertiary = 0
        for count in 1...16 {
            debugPrint("Count: \(count)")
            let newEntry = Entry(context: PersistenceController.shared.container.viewContext)
            newEntry.id = generateUUID()
            newEntry.timestamp = Date.now
            newEntry.event = "Angry: \(count)"
            newEntry.emojion = generateEmoji()
            newEntry.feeling = [primary, secondary, tertiary]
            newEntry.rating = 0
            newEntry.note = generateNote()
            debugPrint(newEntry.feeling)
            saveChanges()
            tertiary += 1
            if count % 2 == 0 {
                secondary += 1
                tertiary = 0
            } else {
                if count == 1 {
                    secondary = 0
                }
            }
        }
    }
    
    func addBadFeelingMockEntries() {
        var primary = 1
        var secondary = 0
        var tertiary = 0
        for count in 1...8 {
            debugPrint("Count: \(count)")
            let newEntry = Entry(context: PersistenceController.shared.container.viewContext)
            newEntry.id = generateUUID()
            newEntry.timestamp = Date.now
            newEntry.event = "Bad: \(count)"
            newEntry.emojion = generateEmoji()
            newEntry.feeling = [primary, secondary, tertiary]
            newEntry.rating = 1
            newEntry.note = generateNote()
            debugPrint(newEntry.feeling)
            saveChanges()
            tertiary += 1
            if count % 2 == 0 {
                secondary += 1
                tertiary = 0
            } else {
                if count == 1 {
                    secondary = 0
                }
            }
        }
    }
    
    func addDisgustedFeelingMockEntries() {
        var primary = 2
        var secondary = 0
        var tertiary = 0
        for count in 1...8 {
            debugPrint("Count: \(count)")
            let newEntry = Entry(context: PersistenceController.shared.container.viewContext)
            newEntry.id = generateUUID()
            newEntry.timestamp = Date.now
            newEntry.event = "Disgusted: \(count)"
            newEntry.emojion = generateEmoji()
            newEntry.feeling = [primary, secondary, tertiary]
            newEntry.rating = 2
            newEntry.note = generateNote()
            debugPrint(newEntry.feeling)
            saveChanges()
            tertiary += 1
            if count % 2 == 0 {
                secondary += 1
                tertiary = 0
            } else {
                if count == 1 {
                    secondary = 0
                }
            }
        }
    }
    
    func addFearfulFeelingMockEntries() {
        var primary = 3
        var secondary = 0
        var tertiary = 0
        for count in 1...12 {
            debugPrint("Count: \(count)")
            let newEntry = Entry(context: PersistenceController.shared.container.viewContext)
            newEntry.id = generateUUID()
            newEntry.timestamp = Date.now
            newEntry.event = "Fearful: \(count)"
            newEntry.emojion = generateEmoji()
            newEntry.feeling = [primary, secondary, tertiary]
            newEntry.rating = 3
            newEntry.note = generateNote()
            debugPrint(newEntry.feeling)
            saveChanges()
            tertiary += 1
            if count % 2 == 0 {
                secondary += 1
                tertiary = 0
            } else {
                if count == 1 {
                    secondary = 0
                }
            }
        }
    }
    
    func addHappyFeelingMockEntries() {
        var primary = 4
        var secondary = 0
        var tertiary = 0
        for count in 1...18 {
            debugPrint("Count: \(count)")
            let newEntry = Entry(context: PersistenceController.shared.container.viewContext)
            newEntry.id = generateUUID()
            newEntry.timestamp = Date.now
            newEntry.event = "Happy: \(count)"
            newEntry.emojion = generateEmoji()
            newEntry.feeling = [primary, secondary, tertiary]
            newEntry.rating = 4
            newEntry.note = generateNote()
            debugPrint(newEntry.feeling)
            saveChanges()
            tertiary += 1
            if count % 2 == 0 {
                secondary += 1
                tertiary = 0
            } else {
                if count == 1 {
                    secondary = 0
                }
            }
        }
    }
    
    func addSadFeelingMockEntries() {
        var primary = 5
        var secondary = 0
        var tertiary = 0
        for count in 1...12 {
            debugPrint("Count: \(count)")
            let newEntry = Entry(context: PersistenceController.shared.container.viewContext)
            newEntry.id = generateUUID()
            newEntry.timestamp = Date.now
            newEntry.event = "Sad: \(count)"
            newEntry.emojion = generateEmoji()
            newEntry.feeling = [primary, secondary, tertiary]
            newEntry.rating = 4
            newEntry.note = generateNote()
            debugPrint(newEntry.feeling)
            saveChanges()
            tertiary += 1
            if count % 2 == 0 {
                secondary += 1
                tertiary = 0
            } else {
                if count == 1 {
                    secondary = 0
                }
            }
        }
    }
    
    func addSurprisedFeelingMockEntries() {
        var primary = 6
        var secondary = 0
        var tertiary = 0
        for count in 1...8 {
            debugPrint("Count: \(count)")
            let newEntry = Entry(context: PersistenceController.shared.container.viewContext)
            newEntry.id = generateUUID()
            newEntry.timestamp = Date.now
            newEntry.event = "Surprised: \(count)"
            newEntry.emojion = generateEmoji()
            newEntry.feeling = [primary, secondary, tertiary]
            newEntry.rating = 4
            newEntry.note = generateNote()
            debugPrint(newEntry.feeling)
            saveChanges()
            tertiary += 1
            if count % 2 == 0 {
                secondary += 1
                tertiary = 0
            } else {
                if count == 1 {
                    secondary = 0
                }
            }
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
        return [Int.random(in: 1...7), Int.random(in: 0...3), Int.random(in: 0...1)]
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
