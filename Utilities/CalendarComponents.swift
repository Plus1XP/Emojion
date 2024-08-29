//
//  CalendarComponents.swift
//  Emojion
//
//  Created by nabbit on 20/08/2024.
//

import Foundation

func checkTodayIsSpecialDay(day: Int, month: Int) -> Bool {
       let calendar = Calendar.current
       let today = Date()
       
       // Create date components for April 16th
       let targetComponents = DateComponents(month: month, day: day)
       
       // Extract current month and day components
       let todayComponents = calendar.dateComponents([.month, .day], from: today)
       
       // Compare the components
       return todayComponents.month == targetComponents.month && todayComponents.day == targetComponents.day
}
