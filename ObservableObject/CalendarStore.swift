//
//  CalendarStore.swift
//  Emojion
//
//  Created by Plus1XP on 01/06/2022.
//

import Foundation

class CalendarStore: ObservableObject {
    
    func dateHasEvents(entries: [Entry], calendar: Calendar, date: Date) -> Bool {
        for entry in entries {
            if calendar.isDate(date, inSameDayAs: entry.timestamp ?? Date()) {
                return true
            }
        }
        return false
    }
    
    func numberOfEventsInDate(entries: [Entry], calendar: Calendar, date: Date) -> Int {
        var count: Int = 0
        for entry in entries {
            if calendar.isDate(date, inSameDayAs: entry.timestamp ?? Date()) {
                count += 1
            }
        }
        return count
    }
}
