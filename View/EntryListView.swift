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
    @State private var entry: Entry
    @State private var canShowAddEntryView: Bool = false
    @State private var canShowEditEntryView: Bool = false
    @State private var hasEntrySaved: Bool = false
    @State private var searchQuery: String = ""

    init(entryStore: EntryStore) {
        self.entryStore = entryStore
        self.entry = Entry(context: PersistenceController.shared.container.viewContext)
        PersistenceController.shared.container.viewContext.delete(entry)
    }
    
    var body: some View {
        List {
            ForEach(searchQuery.isEmpty ? entryStore.entries : entryStore.entries.filter { $0.event!.lowercased().contains(searchQuery.lowercased())}, id: \.self) { entry in
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
        .searchable(text: $searchQuery)
        .toolbar {
            ToolbarItem {
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
