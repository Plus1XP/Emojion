//
//  ChartStore.swift
//  Emojion
//
//  Created by nabbit on 28/12/2022.
//

import SwiftUI

class ChartStore: ObservableObject {
    @Published var chartData: [FeelingStats] = [FeelingStats]() // Remove Soon
    @Published var feelingData: [FeelingData] = [FeelingData]()
    @Published var feelingColors: [Color] = [.red, .green, .gray, .orange, .yellow, .blue, .purple]
    @Published var mostUsedEmoji: (emoji: String, tally: Int) = (emoji:"🫥" , tally:0)
    @Published var leastUsedEmoji: (emoji: String, tally: Int) = (emoji:"🫥" , tally:0)
    @Published var mostUsedPrimaryFeeling: (feeling: String, tally: Int) = (feeling:"" , tally:0)
    @Published var mostUsedSecondaryFeeling: (feeling: String, tally: Int) = (feeling:"" , tally:0)
    @Published var mostUsedTertiaryFeeling: (feeling: String, tally: Int) = (feeling:"" , tally:0)
    @Published var leastUsedPrimaryFeeling: (feeling: String, tally: Int) = (feeling:"" , tally:0)
    @Published var leastUsedSecondaryFeeling: (feeling: String, tally: Int) = (feeling:"" , tally:0)
    @Published var leastUsedTertiaryFeeling: (feeling: String, tally: Int) = (feeling:"" , tally:0)
    @Published var mostUsedDay: (weekDay: String, tally: Int) = (weekDay: "", tally: 0)
    @Published var leastUsedDay: (weekDay: String, tally: Int) = (weekDay: "", tally: 0)
    @Published var mostUsedMonth: (month: String, tally: Int) = (month: "", tally: 0)
    @Published var leastUsedMonth: (month: String, tally: Int) = (month: "", tally: 0)
    @Published var mostUsedYear: (year: String, tally: Int) = (year: "", tally: 0)
    @Published var leastUsedYear: (year: String, tally: Int) = (year: "", tally: 0)
    @Published var oldestEntryDate: String = ""
    @Published var newestEntryDate: String = ""

    private let feelingFinderStore: FeelingFinderStore = FeelingFinderStore() // Remove Soon
    
    init() {
//        self.populateEmptyFeelingData()
    }
    
    func fetchAll(entries: [Entry]) {
        self.feelingData.removeAll()
        self.populateEmptyFeelingData()
        self.fetchFeelingData(entries: entries)
        self.fetchExtremumEmojis(entries: entries)
        self.fetchExtremumFeeling(entries: entries)
        self.fetchExtremumEntryDate(entries: entries)
        self.fetchExtremumUsageDates(entries: entries)
    }

    func updateFeelingStats(entryStore: EntryStore) -> [FeelingStats] { // Remove Soon
        chartData = [FeelingStats]()
        for entry in entryStore.entries {
            chartData.append(FeelingStats(color: getPrimarySelectedFeelingColor(feelingArray: entry.feeling!).description, type: getPrimarySelectedFeelingName(feelingArray: entry.feeling!), date: entry.timestamp!, count: 1))
        }
        return chartData.sorted()
    }
    
    func populateEmptyFeelingData() {
        feelingData.append(FeelingData(type: "Angry", count: 0, color: Color.red, date: [Date.now]))
        feelingData.append(FeelingData(type: "Bad", count: 0, color: Color.green, date: [Date.now]))
        feelingData.append(FeelingData(type: "Disgusted", count: 0, color: Color.gray, date: [Date.now]))
        feelingData.append(FeelingData(type: "Fearful", count: 0, color: Color.orange, date: [Date.now]))
        feelingData.append(FeelingData(type: "Happy", count: 0, color: Color.yellow, date: [Date.now]))
        feelingData.append(FeelingData(type: "Sad", count: 0, color: Color.blue, date: [Date.now]))
        feelingData.append(FeelingData(type: "Surprised", count: 0, color: Color.purple, date: [Date.now]))
        feelingData.sort()
    }
    
    func fetchFeelingData(entries: [Entry]) {
        for entry in entries {
            if entry.feeling?.first == 0 {
                if let existingElement = feelingData.first(where: { $0.type == "Angry" }) {
                    feelingData[feelingData.firstIndex(of: existingElement)!].count += 1
                } else {
                    feelingData.append(FeelingData(type: "Angry", count: 1, color: Color.red, date: [entry.timestamp!]))
                }
            }
            if entry.feeling?.first == 1 {
                if let existingElement = feelingData.first(where: { $0.type == "Bad" }) {
                    feelingData[feelingData.firstIndex(of: existingElement)!].count += 1
                } else {
                    feelingData.append(FeelingData(type: "Bad", count: 1, color: Color.green, date: [entry.timestamp!]))
                }
            }
            if entry.feeling?.first == 2 {
                if let existingElement = feelingData.first(where: { $0.type == "Disgusted" }) {
                    feelingData[feelingData.firstIndex(of: existingElement)!].count += 1
                } else {
                    feelingData.append(FeelingData(type: "Disgusted", count: 1, color: Color.gray, date: [entry.timestamp!]))
                }
            }
            if entry.feeling?.first == 3 {
                if let existingElement = feelingData.first(where: { $0.type == "Fearful" }) {
                    feelingData[feelingData.firstIndex(of: existingElement)!].count += 1
                } else {
                    feelingData.append(FeelingData(type: "Fearful", count: 1, color: Color.orange, date: [entry.timestamp!]))
                }
            }
            if entry.feeling?.first == 4 {
                if let existingElement = feelingData.first(where: { $0.type == "Happy" }) {
                    feelingData[feelingData.firstIndex(of: existingElement)!].count += 1
                } else {
                    feelingData.append(FeelingData(type: "Happy", count: 1, color: Color.yellow, date: [entry.timestamp!]))
                }
            }
            if entry.feeling?.first == 5 {
                if let existingElement = feelingData.first(where: { $0.type == "Sad" }) {
                    feelingData[feelingData.firstIndex(of: existingElement)!].count += 1
                } else {
                    feelingData.append(FeelingData(type: "Sad", count: 1, color: Color.blue, date: [entry.timestamp!]))
                }
            }
            if entry.feeling?.first == 6 {
                if let existingElement = feelingData.first(where: { $0.type == "Surprised" }) {
                    feelingData[feelingData.firstIndex(of: existingElement)!].count += 1
                } else {
                    feelingData.append(FeelingData(type: "Surprised", count: 1, color: Color.purple, date: [entry.timestamp!]))
                }
            }
            
        }
        feelingData.sort()
    }
    
    func fetchExtremumEmojis(entries: [Entry]) {
        var emojiList = [String]()
        
        for entry in entries {
            emojiList.append(entry.emojion ?? "🫥")
        }

        self.mostUsedEmoji = self.returnMostUsedString(stringList: emojiList)
        self.leastUsedEmoji = self.returnLeastUsedString(stringList: emojiList)
    }
    
    func fetchExtremumFeeling(entries: [Entry]) {
        var primaryFeelingList = [String]()
        var secondaryFeelingList = [String]()
        var tertiaryFeelingList = [String]()

        for entry in entries {
            primaryFeelingList.append(getPrimarySelectedFeelingName(feelingArray: entry.feeling!))
            secondaryFeelingList.append(getSecondarySelectedFeelingName(feelingArray: entry.feeling!))
            tertiaryFeelingList.append(getTertiarySelectedFeelingName(feelingArray: entry.feeling!))
        }

        self.mostUsedPrimaryFeeling = returnMostUsedString(stringList: primaryFeelingList)
        self.leastUsedPrimaryFeeling = returnLeastUsedString(stringList: primaryFeelingList)
        self.mostUsedSecondaryFeeling = returnMostUsedString(stringList: secondaryFeelingList)
        self.leastUsedSecondaryFeeling = returnLeastUsedString(stringList: secondaryFeelingList)
        self.mostUsedTertiaryFeeling = returnMostUsedString(stringList: tertiaryFeelingList)
        self.leastUsedTertiaryFeeling = returnLeastUsedString(stringList: tertiaryFeelingList)
    }
    
    func fetchExtremumUsageDates(entries: [Entry])  {
        var weekDayList = [String]()
        var monthList = [String]()
        var yearList = [String]()

        for entry in entries {
            weekDayList.append((Formatter.longDayFormat.string(from: entry.timestamp!)))
            monthList.append((Formatter.longMonthFormat.string(from: entry.timestamp!)))
            yearList.append((Formatter.longYearFormat.string(from: entry.timestamp!)))
        }
        
        self.mostUsedDay = self.returnMostUsedString(stringList: weekDayList)
        self.mostUsedMonth = self.returnMostUsedString(stringList: monthList)
        self.mostUsedYear = self.returnLeastUsedString(stringList: yearList)
        self.leastUsedDay = self.returnLeastUsedString(stringList: weekDayList)
        self.leastUsedMonth = self.returnLeastUsedString(stringList: monthList)
        self.leastUsedYear = self.returnLeastUsedString(stringList: yearList)
    }
    
//    Returns current date if nil
    func fetchExtremumEntryDate(entries: [Entry]) {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "d MMM yyyy"
        let oldestSortedDate = entries.sorted(by: {$0.timestamp?.compare($1.timestamp!) == .orderedAscending}).first?.timestamp ?? Date.now
        let newestSortedDate = entries.sorted(by: {$0.timestamp?.compare($1.timestamp!) == .orderedDescending}).first?.timestamp ?? Date.now
        self.oldestEntryDate = dateformat.string(from: oldestSortedDate)
        self.newestEntryDate = dateformat.string(from: newestSortedDate)
    }
    
    func returnMostUsedString(stringList: [String]) -> (String, Int) {
        var result = ("", 0)
        // Create dictionary to map value to count
        var counts = [String: Int]()

        // Count the values with using forEach
        stringList.forEach { counts[$0] = (counts[$0] ?? 0) + 1 }

        // Find the most frequent value and its count with max(by:)
        if let (string, tally) = counts.max(by: {$0.1 < $1.1}) {
            debugPrint("\(string) occurs \(tally) times")
            result.0 = string
            result.1 = tally
        }
        return result
    }
    
    func returnLeastUsedString(stringList: [String]) -> (String, Int) {
        var result = ("", 0)
        // Create dictionary to map value to count
        var counts = [String: Int]()

        // Count the values with using forEach
        stringList.forEach { counts[$0] = (counts[$0] ?? 0) + 1 }

        // Find the most frequent value and its count with max(by:)
        if let (string, tally) = counts.min(by: {$0.1 < $1.1}) {
            debugPrint("\(string) occurs \(tally) times")
            result.0 = string
            result.1 = tally
        }
        return result
    }
    
    // Rename to return blahblah
    func getPrimarySelectedFeelingName(feelingArray: [Int]) -> String {
        if !feelingArray.isEmpty {
            return feelingFinderStore.feeling[feelingArray[0]].name.capitalized
        } else {
            return ""
        }
    }
    
    func getSecondarySelectedFeelingName(feelingArray: [Int]) -> String {
        if !feelingArray.isEmpty {
            return feelingFinderStore.feeling[feelingArray[0]].secondaryFeelings[feelingArray[1]].name.capitalized
        } else {
            return ""
        }
    }

    func getTertiarySelectedFeelingName(feelingArray: [Int]) -> String {
        if !feelingArray.isEmpty {
            return feelingFinderStore.feeling[feelingArray[0]].secondaryFeelings[feelingArray[1]].tertiaryFeelings[feelingArray[2]].name.capitalized
        } else {
            return ""
        }
    }

    func getPrimarySelectedFeelingColor(feelingArray: [Int]) -> Color {
        if !feelingArray.isEmpty {
            return feelingFinderStore.feeling[feelingArray[0]].color
        } else {
            return Color.primary
        }
    }
}
