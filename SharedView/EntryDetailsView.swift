//
//  PresentMwView.swift
//  Emojion
//
//  Created by Plus1XP on 17/04/2022.
//

import SwiftUI

struct EntryDetailsView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var entryStore: EntryStore
    @State var event: String = ""
    @State var emojion : String = ""
    @State var feeling: [Int] = [0,0,0]
    @State var rating: Int64 = 0
    @State var cachedRating: Int64 = 0
    @State var note: String = ""
    @State var canShowFeelingFinderView: Bool = false
    @Binding var index: Int
    
    var body: some View {
        EditDetailsComponent(event: $event, emojion: $emojion, feeling: $feeling, rating: $rating, cachedRating: $cachedRating, note: $note, canShowFeelingFinderView: $canShowFeelingFinderView, index: self.index)
            .navigationTitle("Emojion Details")
            .navigationBarTitleDisplayMode(.inline)
            .presentationDragIndicator(.visible)
            .onAppear(perform: {
                self.event = entryStore.entries[self.index].event ?? ""
                self.emojion = entryStore.entries[self.index].emojion ?? "🫥"
                self.feeling = entryStore.entries[self.index].feeling ?? [0,0,0]
                self.rating = entryStore.entries[self.index].rating
                self.cachedRating = entryStore.entries[self.index].rating
                self.note = entryStore.entries[self.index].note ?? ""
                
            })
            .background(Color.setViewBackgroundColor(colorScheme: self.colorScheme))
            .opacity(self.canShowFeelingFinderView ? 0.5 : 1)
            .blur(radius: self.canShowFeelingFinderView ? 2.5 : 0, opaque: false)
    }
}

struct EntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetailsView(index: .constant(0))
            .environmentObject(EntryStore())
    }
}
