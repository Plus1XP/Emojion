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
    
    func addChartMockEntries() -> Void {
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
}
