//
//  CalendarCardView.swift
//  Emojion
//
//  Created by Plus1XP on 24/05/2022.
//

import SwiftUI

struct CalendarRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var entryStore: EntryStore
    @EnvironmentObject var feelingFinderStore: FeelingFinderStore
    var emojionFontSize: CGFloat = 55
    var starFontSize: CGFloat = 18
    var starSpacing: CGFloat = -1
    
    let index: Int

    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .center, content: {
                let emojionEmoji = (entryStore.entries[index].emojion == "" || entryStore.entries[index].emojion == nil ? "🫥" : entryStore.entries[index].emojion)!.ToImage(fontSize: emojionFontSize)
                Image(uiImage: emojionEmoji!)
                if let feeling = entryStore.entries[index].feeling {
                    Text(feelingFinderStore.getTertiarySelectedFeelingName(feelingArray: feeling))
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .allowsTightening(true)
                        .scaledToFit()
                        .minimumScaleFactor(0.9)
                }
            })
            .frame(maxWidth: "Out of Control".widthOfString(usingFont: UIFont.systemFont(ofSize: 14)))
            HStack(alignment: .top) {
                VStack() {
                    HStack() {
                        if let event = entryStore.entries[index].event {
                            Text(event)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .allowsTightening(true)
                                .lineLimit(2)
                        }
                        Spacer()
                    }
                    HStack() {
                        Spacer()
                        StarRatingView($entryStore.entries[index].rating, starFontSize, starSpacing)
                        Spacer()
                    }
                }
            }
            .padding([.leading, .trailing], 20)
        }
        .padding(10)
        .background(
            Rectangle()
                .fill(colorScheme == .light ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground))
                .cornerRadius(10.0)
        )
        .overlay(alignment: .topTrailing) {
                Image(systemName: "note.text")
                .foregroundColor(entryStore.entries[index].note == "" ? .clear : .primary)
                    .padding([.top, .trailing], 10)
        }
        .overlay(alignment: .bottomTrailing) {
            HStack {
                if let date = entryStore.entries[index].timestamp {
                    Text(date, formatter: Formatter.shortTimeFormat)
                        .font(.footnote)
                }
            }
            .padding([.bottom, .trailing], 10)

        }
    }
}

struct CalendarRowView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarRowView(index: 0)
            .environmentObject(FeelingFinderStore())
    }
}
