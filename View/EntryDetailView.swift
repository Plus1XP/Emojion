//
//  PresentMwView.swift
//  Emojion
//
//  Created by Plus1XP on 17/04/2022.
//

import SwiftUI

struct EntryDetailView: View {
    @ObservedObject var entryStore: EntryStore
    @State private var canShowEditEntryView: Bool = false
    @State var entry: Entry
    
    var body: some View {
        EntryDetailsCardView(entry: entry)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { self.canShowEditEntryView.toggle() } label: {
                        Label("Edit", systemImage: "pencil")
                            .tint(.blue)
                    }
                }
            }
            .sheet(isPresented: $canShowEditEntryView) {
                EditEntryView(entryStore: entryStore, canShowEditEntryView: $canShowEditEntryView, entry: $entry)
            }
    }
}

struct EntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let entryStore = EntryStore()
        let viewContext = PersistenceController.preview.container.viewContext
        let entry = Entry(context: viewContext)
        
//        EntryDetailView(entryStore: entryStore, entry: entry)
        
        entry.id = UUID()
        entry.timestamp = Date()
        entry.event = "Public Speaking"
        entry.emojion = "😬"
        entry.feeling = "Nervous"
        entry.rating = 3
        entry.note = "Coffee helped anxeity"
        
        return EntryDetailView(entryStore: entryStore, entry: entry)
    }
}
