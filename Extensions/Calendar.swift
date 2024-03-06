//
//  Calendar.swift
//  Emojion
//
//  Created by nabbit on 06/03/2024.
//

import Foundation

extension Calendar {
    private var currentDate: Date { return Date() }
    
    func isDateInLastWeek(_ date: Date) -> Bool {
        guard let lastWeek = self.date(byAdding: DateComponents(weekOfYear: -1), to: currentDate) else {
            return false
        }
        return isDate(date, equalTo: lastWeek, toGranularity: .weekOfYear)
    }
    
    func isDateInLastMonth(_ date: Date) -> Bool {
        guard let lastMonth = self.date(byAdding: DateComponents(month: -1), to: currentDate) else {
            return false
        }
        return isDate(date, equalTo: lastMonth, toGranularity: .month)
    }
    
    func isDateInLastYear(_ date: Date) -> Bool {
        guard let lastYear = self.date(byAdding: DateComponents(year: -1), to: currentDate) else {
            return false
        }
        return isDate(date, equalTo: lastYear, toGranularity: .year)
    }
    
    func isDateInThisWeek(_ date: Date) -> Bool {
        return isDate(date, equalTo: currentDate, toGranularity: .weekOfYear)
    }
    
    func isDateInThisMonth(_ date: Date) -> Bool {
        return isDate(date, equalTo: currentDate, toGranularity: .month)
    }
    
    func isDateInThisYear(_ date: Date) -> Bool {
        return isDate(date, equalTo: currentDate, toGranularity: .year)
    }
    
    func isDateInNextWeek(_ date: Date) -> Bool {
        guard let nextWeek = self.date(byAdding: DateComponents(weekOfYear: 1), to: currentDate) else {
            return false
        }
        return isDate(date, equalTo: nextWeek, toGranularity: .weekOfYear)
    }
    
    func isDateInNextMonth(_ date: Date) -> Bool {
        guard let nextMonth = self.date(byAdding: DateComponents(month: 1), to: currentDate) else {
            return false
        }
        return isDate(date, equalTo: nextMonth, toGranularity: .month)
    }
    
    func isDateInNextYear(_ date: Date) -> Bool {
        guard let nextYear = self.date(byAdding: DateComponents(year: 1), to: currentDate) else {
            return false
        }
        return isDate(date, equalTo: nextYear, toGranularity: .year)
    }
    
    func isDateInFollowingMonth(_ date: Date) -> Bool {
        guard let followingMonth = self.date(byAdding: DateComponents(month: 2), to: currentDate) else {
            return false
        }
        return isDate(date, equalTo: followingMonth, toGranularity: .month)
    }
}
