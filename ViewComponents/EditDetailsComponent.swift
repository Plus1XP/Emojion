//
//  EntryDetailsCardView.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import SwiftUI
import Combine

struct EditDetailsComponent: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var entryStore: EntryStore
    @EnvironmentObject var feelingFinderStore: FeelingFinderStore
    @State var hasEntryChanged: Bool = false
    @State var canEditStarRating: Bool = true
    @Binding var event: String
    @Binding var emojion : String
    @Binding var feeling: [Int]
    @Binding var rating: Int64
    @Binding var cachedRating: Int64
    @Binding var note: String
    @Binding var canShowFeelingFinderView: Bool
    @FocusState private var isNoteFocused: Bool
    @FocusState private var isFieldFocused: Bool
    var emojionFontSize: CGFloat = 125
    var starFontSize: CGFloat = 25
    let sectionTitleColor: Color = Color.secondary
    let index: Int
    
    var body: some View {
        VStack {
            HStack {
                TextField("What are you doing?", text: $event)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .allowsTightening(true)
                    .multilineTextAlignment(.center)
                    .focused($isFieldFocused)
                    .onChange(of: self.event, {
                        if isFieldFocused {
                            self.hasEntryChanged = true
                        }
                    })
            }
            .padding()
            
            HStack {
                EmojiPicker(emoji: $emojion, placeholder: "🫥", textAlignment: .center, fontSize: emojionFontSize)
                    .onReceive(Just(emojion), perform: { _ in
                        // This allow only emoji
                        self.emojion = self.emojion.onlyEmoji()
                        //This allow only emoji and allow only 1 emoji
                        self.emojion = String(self.emojion.onlyEmoji().prefix(1))
                    })
                    .focused($isFieldFocused)
                    .onChange(of: self.emojion, {
                        if isFieldFocused {
                            self.hasEntryChanged = true
                        }
                    })
                    .frame(width: 150, height: 150)
                /*
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 5)
                            .foregroundColor(.gray)
                    )
                    .shadow(radius: 10)
                    .padding()
                 */
                /*
                    .background(
                        Circle()
                            .fill(setFieldBackgroundColor(colorScheme: colorScheme).opacity(1))
                            .cornerRadius(10.0)
                    )
                 */
            }
            
            HStack {
                Text(feelingFinderStore.getTertiarySelectedFeelingName(feelingArray: feeling))
                    .font(.headline)
                    .fontWeight(.medium)
                    .onTapGesture(perform: {
                        canShowFeelingFinderView.toggle()
                    })
                    .popover(isPresented: $canShowFeelingFinderView) {
                        HStack {
                            FeelingFinderView(feeling: $feeling)
                                .onChange(of: self.feeling, {
                                    self.hasEntryChanged = true
                                })
                        }
                        .presentationCompactAdaptation(.popover)
                        .frame(minWidth: 100, maxHeight: 50)
                        .padding()
                        .background(.ultraThinMaterial)
                    }
            }
            .padding(.bottom)
            
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                Text("Experience")
                    .font(.footnote)
                    .textCase(nil)
                    .foregroundStyle(self.sectionTitleColor)
            })
            HStack {
                StarRatingView($rating, starFontSize, $canEditStarRating)
                    .onChange(of: self.rating, {
                        if self.rating != self.cachedRating {
                            debugPrint("now its \(rating)")
                            self.cachedRating = self.rating
                            self.hasEntryChanged = true
                        }
                    })

            }
            .padding(.bottom)
            
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                Text("Notes")
                    .font(.footnote)
                    .textCase(nil)
                    .foregroundStyle(self.sectionTitleColor)
            })
            HStack {
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
                .focused($isFieldFocused)
                .onChange(of: self.note, {
                    if isFieldFocused {
                        self.hasEntryChanged = true
                    }
                })
            }
            .padding()
            .background(
                Rectangle()
                    .fill(Color.setFieldBackgroundColor(colorScheme: colorScheme).opacity(1))
                    .cornerRadius(10.0)
            )
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom)
            
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                Text("Entry Date")
                    .font(.footnote)
                    .textCase(nil)
                    .foregroundStyle(self.sectionTitleColor)
            })
            HStack {
                if let date = entryStore.entries[index].timestamp {
                    Text(date, formatter: Formatter.dateFormatter)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                Rectangle()
                    .fill(Color.setFieldBackgroundColor(colorScheme: colorScheme).opacity(1))
                    .cornerRadius(10.0)
            )
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom)
            
            if hasEntryChanged {
                HStack {
                    Spacer()
                    Button(action: {
                        self.event = entryStore.entries[self.index].event ?? ""
                        self.emojion = entryStore.entries[self.index].emojion ?? "🫥"
                        self.feeling = entryStore.entries[self.index].feeling ?? [0,0,0]
                        self.rating = entryStore.entries[self.index].rating
                        self.cachedRating = entryStore.entries[self.index].rating
                        self.note = entryStore.entries[self.index].note ?? ""
                        self.hasEntryChanged = false
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.red)
                            .background(
                                Circle()
                                    .fill(Color.setFieldBackgroundColor(colorScheme: colorScheme).opacity(1))
                                    .cornerRadius(25.0)
                            )
                    })
                    Spacer()
                    Button(action: {
                        entryStore.entries[self.index].event = self.event
                        entryStore.entries[self.index].emojion = self.emojion
                        entryStore.entries[self.index].feeling = self.feeling
                        entryStore.entries[self.index].rating = self.rating
                        entryStore.entries[self.index].note = self.note
                        entryStore.updateEntry(entry: entryStore.entries[index])
                        self.hasEntryChanged = false
                    }, label: {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.green)
                            .background(
                                Circle()
                                    .fill(Color.setFieldBackgroundColor(colorScheme: colorScheme).opacity(1))
                                    .cornerRadius(25.0)
                            )
                    })
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom)
            }
            Spacer()
        }
    }
}

struct EditDetailsComponent_Previews: PreviewProvider {
    static var previews: some View {
        EditDetailsComponent(event: .constant(Entry.MockEntry.event!), emojion: .constant(Entry.MockEntry.emojion!), feeling: .constant(Entry.MockEntry.feeling!), rating: .constant(Entry.MockEntry.rating), cachedRating: .constant(3), note: .constant(Entry.MockEntry.note!), canShowFeelingFinderView: .constant(false), index: 0)
            .environmentObject(EntryStore())
            .environmentObject(FeelingFinderStore())
        
    }
}
