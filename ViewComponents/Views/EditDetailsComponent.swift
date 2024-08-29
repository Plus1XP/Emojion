//
//  EntryDetailsCardView.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import SwiftUI
import Combine

struct EditDetailsComponent: View {
    @Environment(\.presentationMode) var presentaionMode
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var entryStore: EntryStore
    @EnvironmentObject var feelingFinderStore: FeelingFinderStore
    @State var canSaveChanges: Bool = false
    @State var canEditStarRating: Bool = true
    @State var cancelAnimation: Bool = false
    @State var saveAnimation: Bool = false
    @State private var canHideEmojiField: Bool = false
    @State private var canHideFeelingField: Bool = false
    @State private var canHideRatingField: Bool = false
    @Binding var event: String
    @Binding var emojion : String
    @Binding var feeling: [Int]
    @Binding var rating: Int64
    @Binding var cachedRating: Int64
    @Binding var note: String
    @Binding var canShowFeelingFinderView: Bool
    @Binding var isHideKeyboardButtonAcitve: Bool
    @FocusState private var isFocus: EntryField?
    var emojionFontSize: CGFloat = 75
    var starFontSize: CGFloat = 18.75
    let sectionTitleColor: Color = Color.secondary
    let entry: Entry
    private let bigScale: CGFloat = 1.1
    private let normalScale: CGFloat = 1
    private let smallScale: CGFloat = 0.9
    
    var body: some View {
        VStack {
            HStack {
                TextField("What are you doing?", text: $event, axis: .vertical)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .allowsTightening(true)
                    .multilineTextAlignment(.center)
                    .focused($isFocus, equals: .event)
                    .scaleEffect(self.isFocus == .event ? self.bigScale: self.normalScale)
            }
            .padding(.leading)
            .padding(.trailing)
            
            if !self.canHideEmojiField {
                HStack {
                    EmojiPicker(emoji: $emojion, placeholder: "🫥", textAlignment: .center, fontSize: emojionFontSize)
                        .onReceive(Just(emojion), perform: { _ in
                            // This allow only emoji
                            self.emojion = self.emojion.onlyEmoji()
                            //This allow only emoji and allow only 1 emoji
                            self.emojion = String(self.emojion.onlyEmoji().prefix(1))
                        })
                        .focused($isFocus, equals: .emoji)
                        .scaleEffect(self.isFocus == .emoji ? self.bigScale: self.normalScale)
                        .frame(width: 100, height: 100)
                    /*
                     .resizable()
                     .frame(width: 200, height: 200)
                     .clipShape(Circle())
                     .overlay(
                     Circle()
                     .stroke(lineWidth: 5)
                     .foregroundColor(Color.setFieldBackgroundColor(colorScheme: colorScheme).opacity(1))
                     )
                     .shadow(radius: 10)
                     .padding()
                     */
                        .background(self.emojion == "" ? Circle()
                            .fill(Color.setFieldBackgroundColor(colorScheme: colorScheme).opacity(1))
                            .cornerRadius(10.0) : nil
                        )
                }
            }
            
            if !self.canHideFeelingField {
                HStack {
                    Text(feeling == [0,0,0] ? "What are you feeling?" : feelingFinderStore.getTertiarySelectedFeelingName(feelingArray: feeling))
                        .font(feeling == [0,0,0] ? .body : .headline)
                        .fontWeight(feeling == [0,0,0] ? .regular : .medium)
                        .foregroundColor(feeling == [0,0,0] ? Color(uiColor: .placeholderText) : Color.primary)
                        .onTapGesture(perform: {
                            canShowFeelingFinderView.toggle()
                        })
                        .popover(isPresented: $canShowFeelingFinderView) {
                            HStack {
                                FeelingFinderView(feeling: $feeling)
                                    .focused($isFocus, equals: .feeling)
                            }
                            .presentationCompactAdaptation(.popover)
                            .padding()
                            .frame(minWidth: 215, alignment: .leading)
                            .background(.ultraThinMaterial)
                        }
                }
                .padding(.bottom, (self.isFocus != nil) ? 0 : nil)
            }
            
            if !self.canHideRatingField {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                    Text("Experience")
                        .font(.footnote)
                        .textCase(nil)
                        .foregroundStyle(self.sectionTitleColor)
                })
                HStack {
                    StarRatingView($rating, starFontSize, $canEditStarRating)
                        .focused($isFocus, equals: .rating)
                }
                .padding(.bottom, (self.isFocus != nil) ? 0 : nil)
            }
            
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
                        .scrollContentBackground(.hidden) // <-- hide native background to see custom color
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading) // <-- tell Text to take the entire space available for ScrollView
                        .focused($isFocus, equals: .note)
                        .onChange(of: self.isFocus, {
                            if self.isFocus == .note {
                                withAnimation(.bouncy) {
                                    canHideEmojiField = true
                                    canHideFeelingField = true
                                    canHideRatingField = true
                                }
                            } else {
                                withAnimation(.bouncy) {
                                    canHideEmojiField = false
                                    canHideFeelingField = false
                                    canHideRatingField = false
                                }
                            }
                        })
                    
                    if (self.isFocus != .note ) && self.note == "" {
                        Text("What else would you like to add?")
                            .foregroundColor(Color(uiColor: .placeholderText))
                            .multilineTextAlignment(.leading)
                            .allowsHitTesting(false)
                    }
                })
            }
            .withFocusFieldStyle(colorScheme: self.colorScheme, focusState: self.isFocus == .note)
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom, (self.isFocus != nil) ? 0 : nil)
            
            if !self.isHideKeyboardButtonAcitve {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                    Text("Entry Date")
                        .font(.footnote)
                        .textCase(nil)
                        .foregroundStyle(self.sectionTitleColor)
                })
                HStack {
                    HStack {
                        if let date = entry.timestamp {
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
                    HStack {
                        DeleteEntryDetailsButton(entry: entry)
                    }
                    .padding()
                    .background(
                        Rectangle()
                            .fill(Color.setFieldBackgroundColor(colorScheme: colorScheme).opacity(1))
                            .cornerRadius(10.0)
                    )
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom)
            }
            
            if self.canSaveChanges {
                HStack {
                    Spacer()
                    Button(action: {
                        self.cancelAnimation = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            self.cancelAnimation = false
                            self.loadEntryFromStore()
                            self.canSaveChanges = false
                            self.isHideKeyboardButtonAcitve = false
                            self.hideKeyboard()
                            self.presentaionMode.wrappedValue.dismiss()
                        }
                    }, label: {
                        Image(systemName: self.cancelAnimation ? "xmark.circle" : "xmark.circle.fill")
                    })
                    .buttonStyle(CancelButtonStyle(cancelAnimation: self.cancelAnimation))
                    Spacer()
                    Button(action: {
                        self.saveAnimation = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            self.saveAnimation = false
                            self.saveEntryToStore()
                            self.canSaveChanges = false
                            self.presentaionMode.wrappedValue.dismiss()
                        }
                    }, label: {
                        Image(systemName: self.saveAnimation ? "checkmark.circle" : "checkmark.circle.fill")
                    })
                    .buttonStyle(SaveButtonStyle(saveAnimation: self.saveAnimation))
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .scaleEffect(self.smallScale)
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, (self.isFocus != nil) ? 0 : nil)
                .disabled(!self.canSaveChanges)
            }
            Spacer()
        }
        .onAppear(perform: {
            self.loadEntryFromStore()
        })
        .onChange(of: self.isFocus, {
            // Added else as selecting an emoji is set to 1 character,
            // This hides the keyboard while the button is active.
            if (self.isFocus != nil) {
                self.isHideKeyboardButtonAcitve = true
            } else {
                self.isHideKeyboardButtonAcitve = false
            }
        })
        .onChange(of: self.isHideKeyboardButtonAcitve, {
            if !self.isHideKeyboardButtonAcitve {
                self.hideKeyboard()
            }
        })
        .onChange(of: self.hasAnyEntryValueChanged(), {
            withAnimation(.bouncy, {
                self.canSaveChanges = self.hasAnyEntryValueChanged()
            })
        })
    }
    
    private func hasAnyEntryValueChanged() -> Bool {
        if self.event != self.entry.event || self.emojion != self.entry.emojion || self.feeling != self.entry.feeling || self.rating != self.entry.rating || /*self.cachedRating != self.entry.cachedRating ||*/ self.note != self.entry.note {
            return true
        } else {
            return false
        }
    }
    
    private func loadEntryFromStore() -> Void {
        self.event = entry.event ?? ""
        self.emojion = entry.emojion ?? "🫥"
        self.feeling = entry.feeling ?? [0,0,0]
        self.rating = entry.rating
//        self.cachedRating = entry.rating
        self.note = entry.note ?? ""
        self.entryStore.discardChanges()
    }
    
    private func saveEntryToStore() -> Void {
        entry.event = self.event
        entry.emojion = self.emojion
        entry.feeling = self.feeling
        entry.rating = self.rating
        entry.note = self.note
        entryStore.updateEntry(entry: entry)
    }
}

#Preview {
    @State var entry: Entry = PersistenceController.preview.sampleEntry
    
    return EditDetailsComponent(event: .constant(entry.event ?? ""), emojion: .constant(entry.emojion ?? ""), feeling: .constant(entry.feeling ?? [0,0,0]), rating: .constant(entry.rating ?? 0), cachedRating: .constant(entry.rating ?? 0), note: .constant(entry.note ?? ""), canShowFeelingFinderView: .constant(false), isHideKeyboardButtonAcitve: .constant(false), entry: entry)
        .environmentObject(EntryStore())
        .environmentObject(FeelingFinderStore())
}
