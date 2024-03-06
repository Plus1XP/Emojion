//
//  DateRowView.swift
//  Emojion
//
//  Created by nabbit on 24/12/2023.
//

import SwiftUI

struct DateRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var entryStore: EntryStore
    @EnvironmentObject var feelingFinderStore: FeelingFinderStore
    let entry: Entry

    var body: some View {
        VStack {
            HStack {
                if let date = entry.timestamp {
                    Text(date, formatter: Formatter.mediumMonthFormatter)
                        .textCase(.uppercase)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.red)
                }
            }
            HStack {
                if let date = entry.timestamp {
                    Text(date, formatter: Formatter.shortDayFormat)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                }
            }
            HStack {
                if let date = entry.timestamp {
                    Text(date, formatter: Formatter.shortTimeFormat)
                        .font(.footnote)
                        .allowsTightening(true)
                        .scaledToFit()
                        .minimumScaleFactor(0.7)
                        .foregroundStyle(.primary)
                }
            }
        }
        .frame(maxWidth: "22:56 PM".widthOfString(usingFont: UIFont.systemFont(ofSize: 10)))
        .frame(maxHeight: .infinity)
        .padding(10)
        .background(
            Rectangle()
                .fill(Color.setFieldBackgroundColor(colorScheme: colorScheme).opacity(1))
                .cornerRadius(10.0)
                .padding([.top], 3.8)
                .padding([.bottom], 3.5)
            
        )
    }
}

struct DateRowView_Previews: PreviewProvider {
    static var previews: some View {
        DateRowView(entry: Entry.MockEntry)
    }
}
