//
//  EmojionEditForm.swift
//  Emojion
//
//  Created by Plus1XP on 14/04/2022.
//

import SwiftUI
import Combine

struct EntryFormView: View {
    @State var canEditStarRating: Bool = true
    @Binding var refreshView: Bool
    @Binding var event: String
    @Binding var emojion : String
    @Binding var feeling: [Int]
    @Binding var rating: Int64
    @Binding var note: String
    var starFontSize: CGFloat = 15

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
                HStack {
                    VStack {
                        HStack {
                            Text("Feeling")
                            Spacer()
                        }
                        HStack {
                            FeelingFinderView(feeling: $feeling)
                                .onReceive(NotificationCenter.default
                                    .publisher(for: NSNotification.Name("RefreshFeelingView"))) { _ in
                                        debugPrint("EntryFormView: FeelingView Refreshed")
                                        refreshView.toggle()
                                    }
                        }
                    }
                }
                HStack {
                    Text("Rating")
                    Spacer()
                    StarRatingView($rating, starFontSize, $canEditStarRating)
                        .onReceive(NotificationCenter.default
                            .publisher(for: NSNotification.Name("RefreshStarRatingView"))) { _ in
                                debugPrint("EntryFormView: StarRatingView Refreshed")
                                refreshView.toggle()
                            }
                }
            }
        }
        Section(header: Text("Additional Notes")) {
            HStack {
                TextArea("What else would you like to add?", text: $note)
                    .disableAutocorrection(false)
                    .onReceive(NotificationCenter.default
                        .publisher(for: NSNotification.Name("RefreshNoteFieldView"))) { _ in
                            debugPrint("EntryFormView: NoteFieldView Refreshed")
                            refreshView.toggle()
                        }
            }
        }
    }
}

struct EntryFormView_Previews: PreviewProvider {
    static var previews: some View {
        return EntryFormView(refreshView: .constant(false), event: .constant(Entry.MockEntry.event!), emojion: .constant(Entry.MockEntry.emojion!), feeling: .constant(Entry.MockEntry.feeling!), rating: .constant(Entry.MockEntry.rating), note: .constant(Entry.MockEntry.note!))
    }
}
