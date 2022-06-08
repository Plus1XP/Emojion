//
//  CalendarCardView.swift
//  Emojion
//
//  Created by Plus1XP on 24/05/2022.
//

import SwiftUI

struct CalendarRowView: View {
    @ObservedObject var feelingFinderStore: FeelingFinderStore = FeelingFinderStore()
    @State var entry: Entry
    var emojionFontSize: CGFloat = 50
    var starFontSize: CGFloat = 12
    var starSpacing: CGFloat = -1
    
    private let entryDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        HStack {
            HStack {
                let emojionEmoji = (entry.emojion == "" || entry.emojion == nil ? "🫥" : entry.emojion)!.ToImage(fontSize: emojionFontSize)
                Image(uiImage: emojionEmoji!)
            }
            .padding(.trailing)
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    if let event = entry.event {
                        Text(event)
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    StarRatingView($entry.rating, starFontSize, starSpacing)
                    Spacer()
                }
            }
            Spacer()
            HStack {
                VStack(alignment: .trailing) {
                    Spacer()
                    if let date = entry.timestamp {
                        Text(date, formatter: entryDateFormatter)
                            .font(.footnote)
                    }
                    Spacer()
                    if let feeling = entry.feeling {
                        Text(feelingFinderStore.getTertiarySelectedFeelingName(feelingArray: feeling))
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                    }
                    Spacer()
                }
            }
        }
    }
}

struct CalendarCardView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCardView(entry: Entry.MockEntry)
    }
}
