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

    init(entryStore: EntryStore, canShowEditEntryView: Binding<Bool>, entry: Binding<Entry>) {
        self.entryStore = entryStore
        _canShowEditEntryView = canShowEditEntryView
        _entry = entry
    }
    
    private var updateRating: Binding<Int64> {
        Binding<Int64>(get: {
            return entry.rating
        }, set: {
            entry.rating = $0
        })
    }
    
    var body: some View {
        NavigationView {
            Form {
                EntryFormView(refreshView: $refreshView, event: $entry.event.bound, emojion: $entry.emojion.bound, feeling: $entry.feeling.bound, rating: updateRating, note: $entry.note.bound)
                    .onChange(of: refreshView) { _ in
                            debugPrint("EditEntryView: FeelingView Refreshed")
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
            originalStarRating = updateRating.wrappedValue
            debugPrint("Backup star rating to \(originalStarRating + 1) from \(updateRating.wrappedValue + 1)")
        }
        .onDisappear {
            if !hasEntrySaved {
                updateRating.wrappedValue = originalStarRating
                debugPrint("Resore star rating to: \(updateRating.wrappedValue + 1) from \(originalStarRating + 1)")
            }
        }
    }
}

//struct EditEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        let entryStore = EntryStore()
//        let viewContext = PersistenceController.preview.container.viewContext
//        let entry = Entry(context: viewContext)
//        EditEntryView(entryStore: entryStore, canShowEditEntryView: .constant(false), entry: .constant(entry))
//    }
//}
