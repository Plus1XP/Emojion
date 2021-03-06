//
//  CalendarView.swift
//  Emojion
//
//  Created by Plus1XP on 23/05/2022.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var calendarStore: CalendarStore
    @ObservedObject var entryStore: EntryStore
    private let calendar: Calendar
    private let monthFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    private let fullFormatter: DateFormatter
    
    @State private var selectedDate = Self.now
    private static var now = Date()
    
    @FetchRequest(sortDescriptors: []) var entries: FetchedResults<Entry>
    
    init(calendarStore: CalendarStore, entryStore: EntryStore, calendar: Calendar) {
        self.calendarStore = calendarStore
        self.entryStore = entryStore
        self.calendar = calendar
        self.monthFormatter = DateFormatter(dateFormat: "MMMM YYYY", calendar: calendar)
        self.dayFormatter = DateFormatter(dateFormat: "d", calendar: calendar)
        self.weekDayFormatter = DateFormatter(dateFormat: "EEEEE", calendar: calendar)
        self.fullFormatter = DateFormatter(dateFormat: "dd MMMM yyyy", calendar: calendar)
    }
    
    var body: some View {
        VStack {
            CalendarViewComponent(
                calendarStore: calendarStore,
                entryStore: entryStore,
                calendar: calendar,
                date: $selectedDate,
                content: { date in
                    ZStack {
                        Button(action: { selectedDate = date }) {
                            Text(dayFormatter.string(from: date))
                                .padding(6)
                                // Added to make selection sizes equal on all numbers.
                                .frame(width: 33, height: 33)
                                .foregroundColor(calendar.isDateInToday(date) ? Color.white : .primary)
                                .background(
                                    calendar.isDateInToday(date) ? Color.red
                                    : calendar.isDate(date, inSameDayAs: selectedDate) ? .blue
                                    : .clear
                                )
                                .cornerRadius(7)
                        }
                        
                        if (calendarStore.numberOfEventsInDate(entries: entryStore.entries, calendar: calendar, date: date) >= 2) {
                            Circle()
                                .size(CGSize(width: 5, height: 5))
                                .foregroundColor(Color.green)
                                .offset(x: CGFloat(17),
                                        y: CGFloat(33))
                        }
                        
                        if (calendarStore.numberOfEventsInDate(entries: entryStore.entries, calendar: calendar, date: date) >= 1) {
                            Circle()
                                .size(CGSize(width: 5, height: 5))
                                .foregroundColor(Color.green)
                                .offset(x: CGFloat(24),
                                        y: CGFloat(33))
                        }
                        
                        if (calendarStore.numberOfEventsInDate(entries: entryStore.entries, calendar: calendar, date: date) >= 3) {
                            Circle()
                                .size(CGSize(width: 5, height: 5))
                                .foregroundColor(Color.green)
                                .offset(x: CGFloat(31),
                                        y: CGFloat(33))
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
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        let calendarStore = CalendarStore()
        let entryStore = EntryStore()
        CalendarView(calendarStore: calendarStore, entryStore: entryStore, calendar: Calendar(identifier: .iso8601))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
