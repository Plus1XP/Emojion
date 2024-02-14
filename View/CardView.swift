//
//  EntryListView.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import SwiftUI

struct CardView: View {
    @State private var entry: Entry = Entry(context: PersistenceController.shared.container.viewContext)
    @EnvironmentObject var entryStore: EntryStore
    @State private var canShowAddEntryView: Bool = false
    @State private var canShowEditEntryView: Bool = false
    // Disable once released
//    @State private var isDebugActive: Bool = true
    @State private var canShowDebugMenu: Bool = false
    @State private var canAutoCompleteSearch: Bool = false
    @State private var canResetDate: Bool = false
    @State private var isSearchingDate: Bool = false
    @State private var hasEntrySaved: Bool = false
    @State private var searchQuery: String = ""
    @State private var searchDate: Date = Date.now
    @State private var calendarId: UUID = UUID()
    
    private var searchResults: [Entry] {
        if !searchQuery.isEmpty {
            return entryStore.entries.filter { $0.event!.localizedCaseInsensitiveContains(searchQuery) }
        }
        if isSearchingDate {
            return entryStore.entries.filter { Calendar.current.dateComponents([.year, .month, .day], from: $0.timestamp!) == Calendar.current.dateComponents([.year, .month, .day], from: searchDate) }
        }
        else {
            return entryStore.entries
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    init(entryStore: EntryStore) {
//        UITableView.appearance().sectionFooterHeight = 0
        self.entryStore = entryStore
//        self.entry = Entry(context: PersistenceController.shared.container.viewContext)
        PersistenceController.shared.container.viewContext.delete(entry)
    }
    
    var body: some View {
        List {
            ForEach(entryStore.getSectionHeaders(entries: searchResults).keys.sorted(by: { $0 > $1 }), id:\.self) { key in
                // Removed ! after [key] due to xcode 14.3 update
                if let entries = entryStore.getSectionHeaders(entries: searchResults)[key]
                {
                    Section(header: Text("\(dateFormatter.string(from: key))")) {
                        ForEach(entries, id: \.self){ entry in
                            Section {
                                NavigationLink(destination: EntryDetailsView(entryStore: entryStore, entry: entry)) {
                                    HStack {
                                        DateRowView(entry: entry)
                                        CardRowView(entry: entry)
                                    }
                                }
                            }
//                            .listStyle(.sidebar)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    withAnimation {
                                        entryStore.deleteEntry(entry: entry)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                Button {
                                    self.entry = entry
                                    self.canShowEditEntryView.toggle()
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.blue)
                            }
                        }
                        .onDelete(perform: entryStore.deleteEntry)
                    }
//                    .listStyle(.sidebar)

                }
            }
//            .listStyle(.sidebar)
            .listRowBackground(
                Rectangle()
                     .fill(Color(.clear).opacity(1))
                )
        }
//        .listStyle(.sidebar)
        .searchable(text: $searchQuery, prompt: "Search Emojions") {
            if canAutoCompleteSearch && searchQuery.count > 2 {
                ForEach(searchResults, id: \.self) { entry in
                    Text(entry.event!).searchCompletion(entry.event!)
                }
            }
        }
        .disableAutocorrection(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    DatePicker("Please enter a date", selection: $searchDate, displayedComponents: .date)
                        .labelsHidden()
                        .id(calendarId)
                        // Needed to close calendar picker after selection
                        .onChange(of: Calendar.current.component(.day, from: searchDate)) { _ in
                            calendarId = UUID()
                            if !canResetDate {
                                isSearchingDate = true
                            } else {
                                canResetDate = false
                            }
                        }
                    Button(action: {
                        if isSearchingDate {
                            isSearchingDate = false
                            canResetDate = true
                            searchDate = Date.now
                        }
                    }) {
                        Label("Reset Calendar", systemImage: "xmark")
                            .foregroundColor(Color.red)
                            .disabled(!isSearchingDate)
                            .opacity(isSearchingDate ? 1 : 0)
                    }
                    .hidden(!isSearchingDate)
                    // For Internal debugging
#if DEBUG
                    Button(action: {
                        canShowDebugMenu.toggle()
                    }) {
                        Label("Create Entries", systemImage: canShowDebugMenu ? "chevron.down.circle.fill" : "chevron.down.circle")
                            .foregroundStyle(.primary)
                    }
                    .popover(isPresented: $canShowDebugMenu) {
                        HStack {
                            Button(action: {
                                entryStore.addTestFlightMockEntries()
                            }) {
                                Label("", systemImage: "swift")
                                    .foregroundStyle(.orange, .primary)
                            }
                            Button(action: {
                                entryStore.addRandomMockEntries(numberOfEntries: 30)
                            }) {
                                Label("", systemImage: "calendar.badge.plus")
                                    .foregroundStyle(.green, .primary)
                            }
                            Button(action: {
                                entryStore.deleteAllEntries()
                            }) {
                                Label("", systemImage: "calendar.badge.minus")
                                    .foregroundStyle(.red, .primary)
                            }
                            Button(action: {
                                entryStore.resetCoreData()
                            }) {
                                Label("", systemImage: "xmark.icloud.fill")
                                    .foregroundStyle(.white, .red)
                            }
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                    }
#endif
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.canShowAddEntryView.toggle()
                }) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .onAppear {
            entryStore.fetchEntries()
        }
        .refreshable {
            entryStore.fetchEntries()
        }
        .sheet(isPresented: $canShowAddEntryView) {
            AddEntryView()
        }
        .sheet(isPresented: $canShowEditEntryView, onDismiss: {
            if !hasEntrySaved {
                entryStore.discardChanges()
            }
        }, content: {
            EditEntryView(entryStore: entryStore, canShowEditEntryView: $canShowEditEntryView, hasEntrySaved: $hasEntrySaved, entry: $entry)
        })
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
            .environmentObject(EntryStore())
    }
}
