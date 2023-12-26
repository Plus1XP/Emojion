//
//  DateRowView.swift
//  Emojion
//
//  Created by nabbit on 24/12/2023.
//

import SwiftUI

struct DateRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject var feelingFinderStore: FeelingFinderStore = FeelingFinderStore()
    @State var entry: Entry
    
    private let entryDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    private let entryDateDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()
    
    private let entryDateMonthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }()
    
    private let entryDateYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                let date = entry.timestamp
                Text(date!, formatter: entryDateMonthFormatter)
                    .padding([.leading, .trailing], 3)
                    .textCase(.uppercase)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 2,
                            style: .continuous
                        )
                        .fill(.red.opacity(0.7))
                    )
            }
            HStack {
                let date = entry.timestamp
                Text(date!, formatter: entryDateDayFormatter)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
            }
            HStack {
                let date = entry.timestamp
                Text(date!, formatter: entryDateYearFormatter)
                    .font(.footnote)
                    .foregroundStyle(.primary)
            }
        }
        .padding()
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
        DateRowView(entry: Entry.MockEntry)
    }
}
