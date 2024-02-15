//
//  EditEntryView.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import SwiftUI

struct EditEntryView: View {
    @EnvironmentObject var entryStore: EntryStore
    @State var originalStarRating: Int64 = 5
    @Binding var canShowEditEntryView: Bool
    @Binding var hasEntrySaved: Bool
    @Binding var index: Int
    
    var body: some View {
        NavigationView {
            Form {
                EntryFormView(event: Binding(get: {entryStore.entries[index].event ?? ""}, set: {entryStore.entries[index].event = $0}) , emojion: Binding(get: {entryStore.entries[index].emojion ?? ""}, set: {entryStore.entries[index].emojion = $0}), feeling: Binding(get: {entryStore.entries[index].feeling ?? [0,0,0]}, set: {entryStore.entries[index].feeling = $0}), rating: $entryStore.entries[index].rating, note: Binding(get: {entryStore.entries[index].note ?? ""}, set: {entryStore.entries[index].note = $0}))
                HStack {
                    Spacer()
                    Button(
                        action: {
                            entryStore.deleteEntry(index: index)
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
                        entryStore.updateEntry(entry: entryStore.entries[index])
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
