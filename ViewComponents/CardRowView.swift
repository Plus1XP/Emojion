//
//  EntryCardView.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import SwiftUI

struct CardRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State var entry: Entry
    var emojionFontSize: CGFloat = 55
    @EnvironmentObject var feelingFinderStore: FeelingFinderStore
    var starFontSize: CGFloat = 18
    var starSpacing: CGFloat = -1
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    let emojionEmoji = (entry.emojion == "" || entry.emojion == nil ? "🫥" : entry.emojion)!.ToImage(fontSize: emojionFontSize)
                    Image(uiImage: emojionEmoji!)
                }
            }
            .padding(.trailing, 15)

            VStack(alignment: .leading, content:  {
                HStack {
                    if let event = entry.event {
                        Text(event)
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary)
                    }
                }
                HStack {
                    StarRatingView($entry.rating, starFontSize, starSpacing)
                        .padding(.top, -5)

                }
                HStack {
                    if let feeling = entry.feeling {
                        Text(feelingFinderStore.getTertiarySelectedFeelingName(feelingArray: feeling))
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .foregroundStyle(.primary)
                    }
                }
            })
            Spacer()
        }
        .padding()
        .background(
            Rectangle()
                .fill(setFieldBackgroundColor(colorScheme: colorScheme).opacity(1))
                 .cornerRadius(10.0)
                 .padding([.top, .bottom], 3)
            )
    }
}

private func setFieldBackgroundColor(colorScheme: ColorScheme) -> Color {
    return colorScheme == .light ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground)
}

struct CardRowView_Previews: PreviewProvider {
    static var previews: some View {
        CardRowView(entry: Entry.MockEntry)
    }
}
