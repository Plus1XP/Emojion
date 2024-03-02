//
//  AddEmojionView.swift
//  Emojion
//
//  Created by Plus1XP on 14/04/2022.
//

import SwiftUI

struct AddEntryView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var entryStore: EntryStore
    @State var event: String = ""
    @State var emojion : String = ""
    @State var feeling: [Int] = [0,0,0]
    @State var rating: Int64 = 0
    @State var cachedRating: Int64 = 0
    @State var note: String = ""
    @State var canShowFeelingFinderView: Bool = false
    @State var animate: Bool = false
        
    var body: some View {
        AddDetailsComponent(event: $event, emojion: $emojion, feeling: $feeling, rating: $rating, cachedRating: $cachedRating, note: $note, canShowFeelingFinderView: $canShowFeelingFinderView)
            .navigationTitle("New Emojion")
            .navigationBarTitleDisplayMode(.inline)
            .presentationDragIndicator(.visible)
            .padding(.top)
            .background(Color.setViewBackgroundColor(colorScheme: self.colorScheme))
            .opacity(self.canShowFeelingFinderView ? 0.5 : 1)
            .blur(radius: self.canShowFeelingFinderView ? 2.5 : 0, opaque: false)
    }
}

struct AddEmojionView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
            .environmentObject(EntryStore())
    }
}
