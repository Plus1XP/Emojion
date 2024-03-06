//
//  Date.swift
//  Emojion
//
//  Created by nabbit on 24/12/2023.
//

import Foundation

extension Date {
    func isWithinToday() -> Bool {
        let calendar = Calendar.current
        let now = Date()
        let sevenDaysAgo = calendar.date(byAdding: .day, value: 0, to: now)
        return self >= (sevenDaysAgo ?? now)
    }
    func isWithinYesterday() -> Bool {
        let calendar = Calendar.current
        let now = Date()
        let sevenDaysAgo = calendar.date(byAdding: .day, value: -1, to: now)
        return self >= (sevenDaysAgo ?? now)
    }
    func isWithinLastWeek() -> Bool {
        let calendar = Calendar.current
        let now = Date()
        let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: now)
        return self >= (sevenDaysAgo ?? now)
    }
    func isWithinLastFortnight() -> Bool {
        let calendar = Calendar.current
        let now = Date()
        let sevenDaysAgo = calendar.date(byAdding: .day, value: -14, to: now)
        return self >= (sevenDaysAgo ?? now)
    }
    func isWithinLastMonth() -> Bool {
        let calendar = Calendar.current
        let now = Date()
        let sevenDaysAgo = calendar.date(byAdding: .day, value: -31, to: now)
        return self >= (sevenDaysAgo ?? now)
    }
    func isWithinLastSixMonths() -> Bool {
        let calendar = Calendar.current
        let now = Date()
        let sevenDaysAgo = calendar.date(byAdding: .day, value: -183, to: now)
        return self >= (sevenDaysAgo ?? now)
    }
    func isWithinLastYear() -> Bool {
        let calendar = Calendar.current
        let now = Date()
        let sevenDaysAgo = calendar.date(byAdding: .day, value: -365, to: now)
        return self >= (sevenDaysAgo ?? now)
    }
}
