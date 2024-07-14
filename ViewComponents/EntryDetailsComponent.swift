//
//  EntryDetailsCardView.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import SwiftUI

struct EntryDetailsComponent: View {
    @ObservedObject var feelingFinderStore: FeelingFinderStore = FeelingFinderStore()
    @Binding var entry: Entry
    @State var hasUpdatedStarRating: Bool = false
    var emojionFontSize: CGFloat = 160
    var starFontSize: CGFloat = 25
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    if let date = entry.timestamp {
                        Text(date, formatter: itemFormatter)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.leading)
                    }
                }
                Spacer()
            }
            .padding(.bottom)
            HStack {
                Spacer()
                let emojionEmoji = (entry.emojion == "" || entry.emojion == nil ? "🫥" : entry.emojion)!.ToImage(fontSize: emojionFontSize)
                Image(uiImage: emojionEmoji!)
//                    .resizable()
//                    .frame(width: 200, height: 200)
//                    .clipShape(Circle())
//                    .overlay(
//                        Circle()
//                            .stroke(lineWidth: 8)
//                            .foregroundColor(.gray)
//                    )
//                    .shadow(radius: 10)
                    .padding()
                Spacer()
            }
            .padding(.bottom)
            HStack {
                Spacer()
                VStack {
                    if let feeling = entry.feeling {
                        Text(feelingFinderStore.getTertiarySelectedFeelingName(feelingArray: feeling))
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding(.bottom)
                        StarRatingView($entry.rating, starFontSize)
                            .padding(.bottom)
                    }
                }
                Spacer()
            }
            HStack {
                Spacer()
                VStack {
                    ScrollView {
                        if let note = entry.note {
                            Text(note)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
                Spacer()
            }
            .padding()
            Spacer()
        }
        .navigationTitle(entry.event ?? "")
    }
}

struct EntryDetailsComponent_Previews: PreviewProvider {
    static var previews: some View {
        return EntryDetailsComponent(entry: .constant(Entry.MockEntry))
    }
}
