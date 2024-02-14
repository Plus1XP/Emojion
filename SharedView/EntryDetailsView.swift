//
//  PresentMwView.swift
//  Emojion
//
//  Created by Plus1XP on 17/04/2022.
//

import SwiftUI

struct EntryDetailsView: View {
    @EnvironmentObject var entryStore: EntryStore
    @State private var canShowEditEntryView: Bool = false
    @State private var hasEntrySaved: Bool = false
    @State var index: Int
    
    var body: some View {
        EntryDetailsComponent(index: index)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { self.canShowEditEntryView.toggle() } label: {
                        Label("Edit", systemImage: "pencil")
                            .tint(.blue)
                    }
                }
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

struct EntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetailsView(index: 0)
            .environmentObject(EntryStore())
    }
}
