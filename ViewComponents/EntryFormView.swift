//
//  EmojionEditForm.swift
//  Emojion
//
//  Created by Plus1XP on 14/04/2022.
//

import SwiftUI
import Combine

struct EntryFormView: View {
    @Binding var event: String
    @Binding var emojion : String
    @Binding var feeling: String
    @Binding var rating: Int64
    @Binding var note: String
    @State var hasUpdatedStarRating: Bool = false
    @State var canEditStarRating: Bool = true
    var starFontSize: CGFloat = 15

//    @State var emojiPlaceholder: String = emot2 == "" ? "Assign emoji" : emot2.isSingleEmoji ? emot2 : "\(Image(systemName: "exclamationmark.triangle.fill").foregroundColor(Color.red))"

    
    var body: some View {
        Section(header: Text("Emojion Details")) {
            Group {
                HStack {
                    Text("Event")
                    Spacer()
                    TextField("Name this emojion", text: $event)
                        .multilineTextAlignment(.trailing)
                        .disableAutocorrection(true)
                }
                HStack {
                    Text("Emojion")
                    Spacer()
                    EmojiPicker(emoji: $emojion, placeholder: "Assign emoji" , textAlignment: .right)
                        .onReceive(Just(emojion), perform: { _ in
                            // This allow only emoji
                            self.emojion = self.emojion.onlyEmoji()
                            //This allow only emoji and allow only 1 emoji
                            self.emojion = String(self.emojion.onlyEmoji().prefix(1))
                        })
                }
                // Enum selection
                HStack {
                    Text("Feeling")
                    Spacer()
                    TextField("Describe Emojion", text: $feeling)
                        .multilineTextAlignment(.trailing)
                }
                // Touch 5 Stars
                HStack {
                    Text("Rating")
                    Spacer()
                    StarRatingView($rating, starFontSize, $hasUpdatedStarRating, $canEditStarRating)
                }
            }
        }
        Section(header: Text("Note Details")) {
            HStack {
                Text("Note")
                Spacer()
                TextField("Additional information", text: $note)
                    .disableAutocorrection(false)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

struct EntryFormView_Previews: PreviewProvider {
    static var previews: some View {
//        EntryFormView(event: .constant("Interview"), emojion: .constant("😬"), feeling: .constant("Nervous"), rating: .constant("⭐️⭐️⭐️"), note: .constant("coffee helped with anxeity."))
        
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
        
        return EntryFormView(event: .constant(entry.event!), emojion: .constant(entry.emojion!), feeling: .constant(entry.feeling!), rating: .constant(entry.rating), note: .constant(entry.note!))
        
        
    }
}
