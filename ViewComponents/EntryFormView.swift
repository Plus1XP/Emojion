//
//  EmojionEditForm.swift
//  Emojion
//
//  Created by Plus1XP on 14/04/2022.
//

import SwiftUI
import Combine

struct EntryFormView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State var canEditStarRating: Bool = true
    @Binding var event: String
    @Binding var emojion : String
    @Binding var feeling: [Int]
    @Binding var rating: Int64
    @Binding var note: String
    @FocusState private var isNoteFocused: Bool
    var starFontSize: CGFloat = 15

    var body: some View {
        Section(header: Text("Emojion Details")) {
            Group {
                HStack {
                    Text("Event")
                    Spacer()
                    TextField("What are you doing?", text: $event)
                        .multilineTextAlignment(.trailing)
                        .disableAutocorrection(true)
                }
                HStack {
                    Text("Emojion")
                    Spacer()
                    EmojiPicker(emoji: $emojion, placeholder: "What are you feeling?" , textAlignment: .right)
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
                        }
                    }
                }
                HStack {
                    Text("Rating")
                    Spacer()
                    StarRatingView($rating, starFontSize, $canEditStarRating)
                }
            }
        }
        Section(header: Text("Additional Notes")) {
            // TextEditor does not have a placeholder Using a
            // ZStack & FocusState as a work around.
            ZStack(alignment: .topLeading, content: {
                TextEditor(text: $note)
                    .disableAutocorrection(false)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil) // <-- tell Text to use as many lines as it needs (so no truncating)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading) // <-- tell Text to take the entire space available for ScrollView
                    .focused($isNoteFocused)
                if !self.isNoteFocused && (note == "") {
                    Text("What else would you like to add?")
                        .foregroundColor(Color(uiColor: .placeholderText))
                        .multilineTextAlignment(.leading)
                        .allowsHitTesting(false)
                }
            })
        }
    }
}

private func setFieldBackgroundColor(colorScheme: ColorScheme) -> Color {
    return colorScheme == .light ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground)
}

struct EntryFormView_Previews: PreviewProvider {
    static var previews: some View {
        return EntryFormView(event: .constant(Entry.MockEntry.event!), emojion: .constant(Entry.MockEntry.emojion!), feeling: .constant(Entry.MockEntry.feeling!), rating: .constant(Entry.MockEntry.rating), note: .constant(Entry.MockEntry.note!))
    }
}
