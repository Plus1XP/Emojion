//
//  CalendarViewComponent.swift
//  Emojion
//
//  Created by Plus1XP on 01/06/2022.
//

import SwiftUI

public struct CalendarViewComponent<Day: View, Header: View, Title: View, Trailing: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var calendarStore: CalendarStore
    @EnvironmentObject var entryStore: EntryStore

    // Injected dependencies
    private var calendar: Calendar
    @Binding private var date: Date
    private let content: (Date) -> Day
    private let trailing: (Date) -> Trailing
    private let header: (Date) -> Header
    private let title: (Date) -> Title
    
    // Constants
    private let daysInWeek = 7
    @State private var canShowAddEntryView: Bool = false
    
    @FetchRequest var entries: FetchedResults<Entry>
    
    init(
        calendar: Calendar,
        date: Binding<Date>,
        @ViewBuilder content: @escaping (Date) -> Day,
        @ViewBuilder trailing: @escaping (Date) -> Trailing,
        @ViewBuilder header: @escaping (Date) -> Header,
        @ViewBuilder title: @escaping (Date) -> Title
    ) {
        self.calendar = calendar
        self._date = date
        self.content = content
        self.trailing = trailing
        self.header = header
        self.title = title
        
        _entries = FetchRequest<Entry>(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: false)],
                                       predicate: NSPredicate(
                                        format: "timestamp >= %@ && timestamp <= %@",
                                        Calendar.current.startOfDay(for: date.wrappedValue) as CVarArg,
                                        Calendar.current.startOfDay(for: date.wrappedValue + 86400) as CVarArg))
    }
    
    public var body: some View {
        let month = date.startOfMonth(using: calendar)
        let days = makeDays()
        
        VStack {
            Section(header: title(month)) { }
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(), count: daysInWeek)) {
                    ForEach(days.prefix(daysInWeek), id: \.self, content: header)
                }
                Divider()
                LazyVGrid(columns: Array(repeating: GridItem(), count: daysInWeek)) {
                    ForEach(days, id: \.self) { date in
                        if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                            content(date)
                        } else {
                            trailing(date)
                        }
                    }
                }
            }
            .frame(height: days.count == 42 ? 300 : 270)
//            .shadow(color: colorScheme == .dark ? .white.opacity(0.4) : .black.opacity(0.35), radius: 5)
            List(selection: $entryStore.entrySelection) {
                ForEach(entries, id: \.self) { entry in
                    // This Hack removes the Details Disclosure chevron from list view.
                    ZStack {
                        CalendarRowView(entry: entry)
                        NavigationLink(destination: EntryDetailsView(entry: entry)) {
                            EmptyView()
                        }.opacity(0)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 5, trailing: 20))
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            withAnimation {
                                let feedbackGenerator: UINotificationFeedbackGenerator? = UINotificationFeedbackGenerator()
                                feedbackGenerator?.notificationOccurred(.success)
                                entryStore.deleteEntry(entry: entry)
                                self.entryStore.entrySelection.removeAll()
                            }
                        } label: {
                            Label("", systemImage: "trash")
                                .foregroundStyle(.red, .red)
                        }
                        .tint(.clear)
                    }
                    .listRowBackground(
                        Rectangle()
                            .fill(Color.setViewBackgroundColor(colorScheme: colorScheme))
                    )
                }
            }
            .listStyle(.plain)
        }
        .navigationBarItems(
            leading:
                HStack {
                    
                },
            trailing:
                HStack {
                    Button(action: {
                        self.canShowAddEntryView.toggle()
                    }) {
                        Label("Add Item", systemImage: canShowAddEntryView ? "plus.circle.fill" : "plus")
                            .rotationEffect(.degrees(self.canShowAddEntryView ? 360 : 0))
                            .scaleEffect(self.canShowAddEntryView ? 1.5 : 1)
                            .animation(.easeInOut, value: self.canShowAddEntryView)
                    }
                }
        )
        .onAppear {
//            entryStore.fetchEntries()
            // Makes calendar not load green dots etc.
//            entryStore.fetchEntriesCalendar(date: $date)
        }
        .refreshable {
//            entryStore.fetchEntriesCalendar(date: $date)
        }
        .sheet(isPresented: $canShowAddEntryView) {
            AddEntryView()
        }
    }
}

// MARK: - Conformances

extension CalendarViewComponent: Equatable {
    public static func == (lhs: CalendarViewComponent<Day, Header, Title, Trailing>, rhs: CalendarViewComponent<Day, Header, Title, Trailing>) -> Bool {
        lhs.calendar == rhs.calendar && lhs.date == rhs.date
    }
}

// MARK: - Helpers

private extension CalendarViewComponent {
    func makeDays() -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date),
              let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)
        else {
            return []
        }

        let dateInterval = DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end)
        return calendar.generateDays(for: dateInterval)
    }
}

private extension Calendar {
    func generateDates(
        for dateInterval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates = [dateInterval.start]

        enumerateDates(
            startingAfter: dateInterval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            guard let date = date else { return }

            guard date < dateInterval.end else {
                stop = true
                return
            }

            dates.append(date)
        }

        return dates
    }

    func generateDays(for dateInterval: DateInterval) -> [Date] {
        generateDates(
            for: dateInterval,
            matching: dateComponents([.hour, .minute, .second], from: dateInterval.start)
        )
    }
}

private extension Date {
    func startOfMonth(using calendar: Calendar) -> Date {
        calendar.date(
            from: calendar.dateComponents([.year, .month], from: self)
        ) ?? self
    }
}

extension DateFormatter {
    convenience init(dateFormat: String, calendar: Calendar) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
    }
}
