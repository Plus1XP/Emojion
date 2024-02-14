//
//  AddEmojionView.swift
//  Emojion
//
//  Created by Plus1XP on 14/04/2022.
//

import SwiftUI

struct AddEntryView: View {
    @Environment(\.presentationMode) var presentaionMode
    @State var refreshView: Bool = false
    @EnvironmentObject var entryStore: EntryStore
    @State var event: String = ""
    @State var emojion: String = ""
    @State var feeling: [Int] = [0,0,0]
    @State var rating: Int64 = 0
    @State var note: String = ""
        
    var body: some View {
        NavigationView {
            Form {
                EntryFormView(refreshView: $refreshView, event: $event, emojion: $emojion, feeling: $feeling, rating: $rating, note: $note)
                    .onChange(of: refreshView) { _ in
                            debugPrint("AddEntryView: Feeling/Star View Refreshed")
                        }
            }
            .navigationTitle("New Emojion")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentaionMode.wrappedValue.dismiss()
                    }) {
                        Label("Dismiss", systemImage: "chevron.down")
                            .foregroundColor(Color.red)
                    }
                 }
                 ToolbarItem(placement: .navigationBarTrailing) {
                     Button(action: {
                         entryStore.addNewEntry(event: event, emojion: emojion, feeling: feeling, rating: rating, note: note)
                         presentaionMode.wrappedValue.dismiss()
                     }) {
                         Label("Save", systemImage: "checkmark")
                             .foregroundColor(Color.green)
                     }
                  }
              }
        }
    }
}

struct AddEmojionView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
            .environmentObject(EntryStore())
    }
}
