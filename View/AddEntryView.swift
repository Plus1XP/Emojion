//
//  AddEmojionView.swift
//  Emojion
//
//  Created by Plus1XP on 14/04/2022.
//

import SwiftUI

struct AddEntryView: View {
    @Environment(\.presentationMode) var presentaionMode
    @ObservedObject var entryStore: EntryStore
    @State var event: String = ""
    @State var emojion: String = ""
    @State var feeling: String = ""
    @State var rating: Int64 = 0
    @State var note: String = ""
        
    var body: some View {
        NavigationView {
            Form {
                EntryFormView(event: $event, emojion: $emojion, feeling: $feeling, rating: $rating, note: $note)
            }
            .navigationTitle("New Emojion")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentaionMode.wrappedValue.dismiss()
                    }) {
                        Label("Dismiss", systemImage: "xmark.circle")
                    }
                 }
                 ToolbarItem(placement: .navigationBarTrailing) {
                     Button(action: {
                         entryStore.addNewEntry(event: event, emojion: emojion, feeling: feeling, rating: rating, note: note)
                         presentaionMode.wrappedValue.dismiss()
                     }) {
                         Label("Save", systemImage: "sdcard")
                     }
                  }
              }
        }
    }
}

struct AddEmojionView_Previews: PreviewProvider {
    static var previews: some View {
        let entryStore = EntryStore()
        AddEntryView(entryStore: entryStore)
    }
}
