//
//  EntryListView.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var entryStore: EntryStore
    @State private var canShowAddEntryView: Bool = false
    @State private var canShowEditEntryView: Bool = false
    @State private var canShowDebugMenu: Bool = false
    @State var canShowDebugContent: Bool = true
    @State private var canAutoCompleteSearch: Bool = false
    @State private var canResetDate: Bool = false
    @State private var hasEntrySaved: Bool = false
    @State private var calendarId: UUID = UUID()
    @State var index: Int = 0
    
    var body: some View {
        List(selection: $entryStore.entrySelection) {
            ForEach(entryStore.getSectionHeadersFromSearchResults().keys.sorted(by: { $0 > $1 }), id: \.self) { key in
                // Removed ! after [key] due to xcode 14.3 update
                if let entries = entryStore.getSectionHeadersFromSearchResults()[key]
                {
                    Section(header: Text("\(Formatter.longDayFormat.string(from: key))")) {
                        ForEach(entries, id: \.self){ entry in
                            Section {
                                // This Hack removes the Details Disclosure chevron from list view.
                                ZStack {
                                    HStack(alignment: .top) {
                                        if canShowDebugContent {
                                            DateRowView(index: entryStore.entries.firstIndex(of: entry)!)
                                            CardRowView(index: entryStore.entries.firstIndex(of: entry)!)
                                        }
                                    }
                                    NavigationLink(destination: EntryDetailsView(index: entryStore.entries.firstIndex(of: entry)!)) {
                                        EmptyView()
                                    }
                                    .opacity(0)
                                }
                            }
                            .listRowSeparator(.hidden)
//                            .listRowInsets(EdgeInsets())
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    withAnimation {
                                        entryStore.deleteEntry(index: index)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                Button {
                                    self.index = entryStore.entries.firstIndex(of: entry)!
                                    self.canShowEditEntryView.toggle()
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.blue)
                            }
                        }
                        .onDelete(perform: entryStore.deleteEntry)
                    }
                }
            }
            .listRowBackground(
                Rectangle()
                    .fill(Color(.clear).opacity(1))
            )
        }
        .searchable(text: $entryStore.searchText, prompt: "Search Emojions") {
            if canAutoCompleteSearch && entryStore.searchText.count > 2 {
                ForEach(entryStore.searchResults, id: \.self) { entry in
                    Text(entry.event!).searchCompletion(entry.event!)
                }
            }
        }
        .disableAutocorrection(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    DatePicker("Please enter a date", selection: $entryStore.searchDate, displayedComponents: .date)
                        .labelsHidden()
                        .id(calendarId)
                        // Needed to close calendar picker after selection
                        .onChange(of: Calendar.current.component(.day, from: entryStore.searchDate)) { _ in
                            calendarId = UUID()
                            if !canResetDate {
                                entryStore.isSearchingDate = true
                            } else {
                                canResetDate = false
                            }
                        }
                    Button(action: {
                        if entryStore.isSearchingDate {
                            entryStore.isSearchingDate = false
                            canResetDate = true
                            entryStore.searchDate = Date.now
                        }
                    }) {
                        Label("Reset Calendar", systemImage: "xmark")
                            .foregroundColor(Color.red)
                            .disabled(!entryStore.isSearchingDate)
                            .opacity(entryStore.isSearchingDate ? 1 : 0)
                    }
                    .hidden(!entryStore.isSearchingDate)
                    // For Internal debugging
#if DEBUG
                    Button(action: {
                        self.canShowDebugMenu.toggle()
                        // Added to hide view and stop crashing on index out of bounds,
                        // When content is deleted from subview.
                        self.canShowDebugContent.toggle()
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
            EditEntryView(canShowEditEntryView: $canShowEditEntryView, hasEntrySaved: $hasEntrySaved, index: $index)
        })
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
            .environmentObject(EntryStore())
    }
}
