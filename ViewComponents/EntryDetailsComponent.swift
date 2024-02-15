//
//  EntryDetailsCardView.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import SwiftUI

struct EntryDetailsComponent: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var entryStore: EntryStore
    @EnvironmentObject var feelingFinderStore: FeelingFinderStore
    var emojionFontSize: CGFloat = 125
    var starFontSize: CGFloat = 25
    let sectionTitleColor: Color = Color.secondary
    let index: Int
    
    var body: some View {
        VStack {
            HStack {
                Text(entryStore.entries[index].event ?? "")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .allowsTightening(true)
            }
            .padding()
            
            HStack {
                let emojionEmoji = (entryStore.entries[index].emojion == "" || entryStore.entries[index].emojion == nil ? "🫥" : entryStore.entries[index].emojion)!.ToImage(fontSize: emojionFontSize)
                Image(uiImage: emojionEmoji!)
                /*
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 5)
                            .foregroundColor(.gray)
                    )
                    .shadow(radius: 10)
                    .padding()
                 */
                /*
                    .background(
                        Circle()
                            .fill(setFieldBackgroundColor(colorScheme: colorScheme).opacity(1))
                            .cornerRadius(10.0)
                    )
                 */
            }
            HStack {
                if let feeling = entryStore.entries[index].feeling {
                    Text(feelingFinderStore.getTertiarySelectedFeelingName(feelingArray: feeling))
                        .font(.headline)
                        .fontWeight(.medium)
                }
            }
            .padding(.top, -15)
            .padding(.bottom)

            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                Text("Experience")
                    .font(.footnote)
                    .textCase(nil)
                    .foregroundStyle(self.sectionTitleColor)
            })
            HStack {
                StarRatingView($entryStore.entries[index].rating, starFontSize)
            }
            .padding(.bottom)
            
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                Text("Notes")
                    .font(.footnote)
                    .textCase(nil)
                    .foregroundStyle(self.sectionTitleColor)
            })
            HStack {
                ScrollView { // <-- add scroll around Text
                    Text(entryStore.entries[index].note ?? "")
                        .lineLimit(nil) // <-- tell Text to use as many lines as it needs (so no truncating)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading) // <-- tell Text to take the entire space available for ScrollView
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // <-- if needed, tell ScrollView to use the full size of its parent too
            }
            .padding()
            .background(
                Rectangle()
                    .fill(Color.setFieldBackgroundColor(colorScheme: colorScheme).opacity(1))
                    .cornerRadius(10.0)
            )
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom)
            
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                Text("Entry Date")
                    .font(.footnote)
                    .textCase(nil)
                    .foregroundStyle(self.sectionTitleColor)
            })
            HStack {
                if let date = entryStore.entries[index].timestamp {
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
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom)
            Spacer()
        }
        .navigationTitle("Emojion Details")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.setViewBackgroundColor(colorScheme: self.colorScheme))
    }
}

struct EntryDetailsComponent_Previews: PreviewProvider {
    static var previews: some View {
        return EntryDetailsComponent(index: 0)
    }
}
