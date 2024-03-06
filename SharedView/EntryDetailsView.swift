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
    let entry: Entry
    
    var body: some View {
        //MARK: Refactor & Combine Add & Edit Details Views & Components
        EditDetailsComponent(event: $event, emojion: $emojion, feeling: $feeling, rating: $rating, cachedRating: $cachedRating, note: $note, canShowFeelingFinderView: $canShowFeelingFinderView, entry: entry)
            .navigationTitle("Emojion Details")
            .navigationBarTitleDisplayMode(.inline)
            .presentationDragIndicator(.visible)
            .onAppear(perform: {
                self.event = entry.event ?? ""
                self.emojion = entry.emojion ?? "🫥"
                self.feeling = entry.feeling ?? [0,0,0]
                self.rating = entry.rating
                self.cachedRating = entry.rating
                self.note = entry.note ?? ""
                
            })
            .background(Color.setViewBackgroundColor(colorScheme: self.colorScheme))
            .opacity(self.canShowFeelingFinderView ? 0.5 : 1)
            .blur(radius: self.canShowFeelingFinderView ? 2.5 : 0, opaque: false)
    }
}

struct EntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetailsView(entry: Entry.MockEntry)
            .environmentObject(EntryStore())
    }
}
