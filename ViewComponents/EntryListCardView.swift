//
//  EntryCardView.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import SwiftUI

struct EntryListCardView: View {
    @ObservedObject var feelingFinderStore: FeelingFinderStore = FeelingFinderStore()
    @State var entry: Entry
    var emojionFontSize: CGFloat = 55
    var starFontSize: CGFloat = 18
    var starSpacing: CGFloat = -1
    
    private let entryDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                if let event = entry.event, let date = entry.timestamp {
                    Text(event)
                        .font(.headline)
                        .fontWeight(.semibold)
                    Spacer()
                    Text(date, formatter: entryDateFormatter)
                        .font(.footnote)
                }
            }
            HStack {
                let emojionEmoji = (entry.emojion == "" || entry.emojion == nil ? "🫥" : entry.emojion)!.ToImage(fontSize: emojionFontSize)
                Image(uiImage: emojionEmoji!)
//                    .resizable()
//                    .frame(width: 50, height: 50)
                Spacer()
                VStack {
                    StarRatingView($entry.rating, starFontSize, starSpacing)
//                        .border(.red)
                }
                Spacer()
            }
            HStack {
                if let feeling = entry.feeling {
                    Text(feelingFinderStore.getTertiarySelectedFeelingName(feelingArray: feeling))
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                Spacer()
            }
        }
        .padding([.top, .bottom])
    }
}

struct EntryListCardView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListCardView(entry: Entry.MockEntry)
    }
}
