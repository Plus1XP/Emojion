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
    let index: Int

    var body: some View {
        VStack {
            HStack {
                // TODO: Guard let for index & if let for entries
                // Might fix index out of bunds?
                if let date = entryStore.entries[index].timestamp {
                    Text(date, formatter: Formatter.mediumMonthFormatter)
                        .textCase(.uppercase)
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundStyle(.red)
                }
            }
            HStack {
                if let date = entryStore.entries[index].timestamp {
                    Text(date, formatter: Formatter.shortDayFormat)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                }
            }
            HStack {
                if let date = entryStore.entries[index].timestamp {
                    Text(date, formatter: Formatter.shortTimeFormat)
                        .font(.footnote)
                        .allowsTightening(true)
                        .scaledToFit()
                        .minimumScaleFactor(0.8)
                        .foregroundStyle(.primary)
                }
            }
        }
        .frame(maxWidth: "22:56 PM".widthOfString(usingFont: UIFont.systemFont(ofSize: 10)))
        .frame(maxHeight: .infinity)
        .padding(10)
        .background(
            Rectangle()
                .fill(setFieldBackgroundColor(colorScheme: colorScheme).opacity(1))
                 .cornerRadius(10.0)
                 .padding([.top], 3.8)
                 .padding([.bottom], 3.5)

            )
    }
}

private func setFieldBackgroundColor(colorScheme: ColorScheme) -> Color {
    return colorScheme == .light ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground)
}

struct DateRowView_Previews: PreviewProvider {
    static var previews: some View {
        DateRowView(index: 0)
    }
}
