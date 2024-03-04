//
//  EntryCardView.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import SwiftUI

struct CardRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var entryStore: EntryStore
    @EnvironmentObject var feelingFinderStore: FeelingFinderStore
    var emojionFontSize: CGFloat = 50
    var starFontSize: CGFloat = 18
    var starSpacing: CGFloat = -1
    let entry: Entry

    var body: some View {
        HStack {
            VStack {
                HStack {
                    if let emojionEmoji = (entry.emojion == "" || entry.emojion == nil ? "🫥" : entry.emojion)!.ToImage(fontSize: emojionFontSize) {
                        Image(uiImage: emojionEmoji)
                    }
                }
                HStack {
                    if let feeling = entry.feeling {
                        Text(feeling == [0,0,0] ? "" : feelingFinderStore.getTertiarySelectedFeelingName(feelingArray: feeling))
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary)
                            .allowsTightening(true)
                            .scaledToFit()
                            .minimumScaleFactor(0.8)
                    }
                }
            }
            .frame(maxWidth: "Out of Control".widthOfString(usingFont: UIFont.systemFont(ofSize: 12)))
            VStack(alignment: .leading, content:  {
                HStack {
                    if let event = entry.event {
                        Text(event)
                            .font(.callout)
                            .fontWeight(.medium)
                            .lineLimit(2)
                            .allowsTightening(true)
                            .foregroundStyle(.primary)
                    }
                }
                HStack {
                    Spacer()
                    // have to cast to int (non fixed size int) to check nil.
                    if let rating = entry.rating as? NSNumber {
                        var int64value = rating.int64Value // This is an `Int64`
                        StarRatingView(Binding(get: {int64value}, set: {int64value = $0}), starFontSize, starSpacing)
                            .padding(.top, -5)
                    }
                    Spacer()
                }
            })
            .padding([.leading], 5)
            .padding([.trailing], 20)
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .padding(10)
        .background(
            Rectangle()
                .fill(Color.setFieldBackgroundColor(colorScheme: colorScheme).opacity(1))
                .cornerRadius(10.0)
                .padding([.top, .bottom], 3)
        )
        .overlay(alignment: .topTrailing) {
            if let note = entry.note {
                Image(systemName: "note.text")
                    .foregroundColor(note == "" ? .clear : .primary)
                    .padding([.top, .trailing], 10)
            }
        }
    }
}

struct CardRowView_Previews: PreviewProvider {
    static var previews: some View {
        CardRowView(entry: Entry.MockEntry)
    }
}
