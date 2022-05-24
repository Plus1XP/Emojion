//
//  EntryListView.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import SwiftUI
import CoreData

struct EntryListView: View {
    @ObservedObject var entryStore: EntryStore
    @State private var entry: Entry = Entry(context: PersistenceController.shared.container.viewContext)
    @State private var canShowAddEntryView: Bool = false
    @State private var canShowEditEntryView: Bool = false
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

    init(entryStore: EntryStore) {
        self.entryStore = entryStore
//        self.entry = Entry(context: PersistenceController.shared.container.viewContext)
        PersistenceController.shared.container.viewContext.delete(entry)
    }
    
    var body: some View {
        List {
            ForEach(searchResults, id: \.self) { entry in
                Section {
                    NavigationLink(destination: EntryDetailView(entryStore: entryStore, entry: entry)) {
                        EntryListCardView(entry: entry)
                    }
                }
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
        .navigationTitle("Emojions")
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
                        Label("Reset Calendar", systemImage: "xmark.circle.fill")
                            .foregroundColor(Color.red)
                            .disabled(!isSearchingDate)
                            .opacity(isSearchingDate ? 1 : 0)
                    }

                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.canShowAddEntryView.toggle()
                }) {
                    Label("Add Item", systemImage: "plus.circle")
                }
            }
        }
        .onAppear {
            entryStore.fetchEntries()
        }
        .sheet(isPresented: $canShowAddEntryView) {
            AddEntryView(entryStore: entryStore)
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

struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        let entryStore = EntryStore()
        EntryListView(entryStore: entryStore)
    }
}
