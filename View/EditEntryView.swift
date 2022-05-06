//
//  EditEntryView.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import SwiftUI

struct EditEntryView: View {
    @ObservedObject var entryStore: EntryStore
    @State var refreshView: Bool = false
    @State var hasEntrySaved: Bool = false
    @State var originalStarRating: Int64 = 5
    @Binding var canShowEditEntryView: Bool
    @Binding var entry: Entry
    
    var body: some View {
        NavigationView {
            Form {
                EntryFormView(refreshView: $refreshView, event: $entry.event.bound, emojion: $entry.emojion.bound, feeling: $entry.feeling.bound, rating: $entry.rating, note: $entry.note.bound)
                    .onChange(of: refreshView) { _ in
                            debugPrint("EditEntryView: Feeling/Star View Refreshed")
                        }
                HStack {
                    Spacer()
                    Button(
                        action: {
                            entryStore.deleteEntry(entry: entry)
                            canShowEditEntryView.toggle()
                        },
                        label: {
                            Label("Delete Entry", systemImage: "trash")
                                .foregroundColor(.red)
                        })
                    Spacer()
                }
            }
            .navigationTitle("Edit Emojion")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        canShowEditEntryView.toggle()
                    }) {
                        Label("Dismiss", systemImage: "xmark.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        entryStore.updateEntry(entry: entry)
                        hasEntrySaved = true
                        canShowEditEntryView.toggle()
                    }) {
                        Label("Save", systemImage: "sdcard")
                    }
                }
            }
        }
        .onAppear {
            hasEntrySaved = false
            MockDataObject.temp = MockDataObject.backupEntry(originalEntry: entry)
            debugPrint("Original Entry Backup")
        }
        .onDisappear {
            if !hasEntrySaved {
                entry = MockDataObject.restoreEntry(originalEntry: entry, clonedEntry: MockDataObject.temp)
                MockDataObject.temp = MockDataObject.empty
                debugPrint("Original Entry Restore")
            } else {
                MockDataObject.temp = MockDataObject.empty
                debugPrint("Backup Entry Clear")
            }
        }
    }
}

struct EditEntryView_Previews: PreviewProvider {
    static var previews: some View {
        let entryStore = EntryStore()
        let viewContext = PersistenceController.preview.container.viewContext
        let entry = Entry(context: viewContext)
        let mock = MockDataObject.restoreEntry(originalEntry: entry, clonedEntry: MockDataObject.entry)
        EditEntryView(entryStore: entryStore, canShowEditEntryView: .constant(false), entry: .constant(mock))
    }
}
