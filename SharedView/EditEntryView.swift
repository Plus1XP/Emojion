//
//  EditEntryView.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import SwiftUI

struct EditEntryView: View {
    @State var refreshView: Bool = false
    @EnvironmentObject var entryStore: EntryStore
    @State var originalStarRating: Int64 = 5
    @Binding var canShowEditEntryView: Bool
    @Binding var hasEntrySaved: Bool
    @Binding var entry: Entry
    
    // This computed property is needed to notify child view of property change
    // If remoed the child view UI will not refresh.
    private var entryNote: Binding<String?> {
        Binding<String?>(get: {
            return entry.note
        }, set: {
            NotificationCenter.default.post(name: Notification.Name("RefreshNoteFieldView"), object: nil)
            entry.note = $0
        })
    }
    
    var body: some View {
        NavigationView {
            Form {
                EntryFormView(refreshView: $refreshView, event: $entry.event.bound, emojion: $entry.emojion.bound, feeling: $entry.feeling.bound, rating: $entry.rating, note: entryNote.bound)
                    .onChange(of: refreshView) { _ in
                        debugPrint("EditEntryView: EntryForm View Refreshed")
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
                        Label("Dismiss", systemImage: "chevron.down")
                            .foregroundColor(Color.red)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        entryStore.updateEntry(entry: entry)
                        hasEntrySaved = true
                        canShowEditEntryView.toggle()
                    }) {
                        Label("Save", systemImage: "checkmark")
                            .foregroundColor(Color.green)
                    }
                }
            }
        }
        .onAppear {
            hasEntrySaved = false
        }
    }
}

struct EditEntryView_Previews: PreviewProvider {
    static var previews: some View {
        EditEntryView(canShowEditEntryView: .constant(false), hasEntrySaved: .constant(false), index: .constant(0))
            .environmentObject(EntryStore())
    }
}
