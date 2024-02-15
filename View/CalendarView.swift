//
//  CalendarView.swift
//  Emojion
//
//  Created by Plus1XP on 23/05/2022.
//

import SwiftUI

struct CalendarView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var calendarStore: CalendarStore
    @EnvironmentObject var entryStore: EntryStore
    @State private var selectedDate = Self.now
    private let calendar: Calendar
    private let monthFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    private let fullFormatter: DateFormatter
    private static var now = Date()
        
    init(calendar: Calendar) {
        self.calendar = calendar
        self.monthFormatter = DateFormatter(dateFormat: "MMMM YYYY", calendar: calendar)
        self.dayFormatter = DateFormatter(dateFormat: "d", calendar: calendar)
        self.weekDayFormatter = DateFormatter(dateFormat: "EEEEE", calendar: calendar)
        self.fullFormatter = DateFormatter(dateFormat: "dd MMMM yyyy", calendar: calendar)
    }
    
    var body: some View {
        VStack {
            CalendarViewComponent(
                calendar: calendar,
                date: $selectedDate,
                content: { date in
                    ZStack {
                        Button(action: { selectedDate = date }) {
                            Text(dayFormatter.string(from: date))
                                .padding(5)
                                // Added to make selection sizes equal on all numbers.
                                .frame(width: 33, height: 33)
                                .fontWeight(
                                    calendar.isDateInToday(date) ?
                                        .bold : calendar.isDate(date, inSameDayAs: selectedDate) ?
                                        .bold : .regular
                                )
                                .foregroundColor(
                                    calendar.isDateInToday(date) ?
                                    calendar.isDate(date, inSameDayAs: selectedDate) ?
                                        .white : .red : 
                                    calendar.isDate(date, inSameDayAs: selectedDate) ?
                                    colorScheme == .light ? .white : .black : 
                                        colorScheme == .light ? .black : .white
                                )
                                .background(
                                    calendar.isDateInToday(date) ? 
                                    calendar.isDate(date, inSameDayAs: selectedDate) ?
                                        .red : .clear :
                                        calendar.isDate(date, inSameDayAs: selectedDate) ?
                                    colorScheme == .light ? .black : .white : 
                                            .clear
                                )
                                .clipShape(.circle)
//
                        }
                        
                        if (calendarStore.numberOfEventsInDate(entries: entryStore.entries, calendar: calendar, date: date) >= 2) {
                            Circle()
                                .size(CGSize(width: 5, height: 5))
                                .foregroundColor(Color.green)
//                                .shadow(color: colorScheme == .light ? .gray : .white, radius: 1)
                                .offset(x: CGFloat(17),
                                        y: CGFloat(34))
                        }
                        
                        if (calendarStore.numberOfEventsInDate(entries: entryStore.entries, calendar: calendar, date: date) >= 1) {
                            Circle()
                                .size(CGSize(width: 5, height: 5))
                                .foregroundColor(Color.green)
//                                .shadow(color: colorScheme == .light ? .gray : .white, radius: 1)
                                .offset(x: CGFloat(24),
                                        y: CGFloat(34))
                        }
                        
                        if (calendarStore.numberOfEventsInDate(entries: entryStore.entries, calendar: calendar, date: date) >= 3) {
                            Circle()
                                .size(CGSize(width: 5, height: 5))
                                .foregroundColor(Color.green)
//                                .shadow(color: colorScheme == .light ? .gray : .white, radius: 1)
                                .offset(x: CGFloat(31),
                                        y: CGFloat(34))
                        }
                    }
                },
                trailing: { date in
                    Text(dayFormatter.string(from: date))
                        .foregroundColor(.secondary)
                },
                header: { date in
                    Text(weekDayFormatter.string(from: date)).fontWeight(.bold)
                },
                title: { date in
                    HStack {
                        
                        Button {
                            guard let newDate = calendar.date(
                                byAdding: .month,
                                value: -1,
                                to: selectedDate
                            ) else {
                                return
                            }
                            
                            selectedDate = newDate
                            
                        } label: {
                            Label(
                                title: { Text("Previous") },
                                icon: {
                                    Image(systemName: "chevron.left")
                                        .font(.title2)
                                }
                            )
                            .labelStyle(IconOnlyLabelStyle())
                            .padding(.horizontal)
                        }
                        
                        Spacer()
                        
                        Button {
                            selectedDate = Date.now
                        } label: {
                            Text(monthFormatter.string(from: date))
                                .foregroundColor(.blue)
                                .font(.title2)
                                .padding(2)
                        }
                        
                        Spacer()
                        
                        Button {
                            guard let newDate = calendar.date(
                                byAdding: .month,
                                value: 1,
                                to: selectedDate
                            ) else {
                                return
                            }
                            
                            selectedDate = newDate
                            
                        } label: {
                            Label(
                                title: { Text("Next") },
                                icon: {
                                    Image(systemName: "chevron.right")
                                        .font(.title2)
                                }
                            )
                            .labelStyle(IconOnlyLabelStyle())
                            .padding(.horizontal)
                        }
                    }
                }
            )
            .equatable()
        }
        .background(Color.setViewBackgroundColor(colorScheme: colorScheme))
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(calendar: Calendar(identifier: .iso8601))
            .environmentObject(EntryStore())
            .environmentObject(CalendarStore())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
