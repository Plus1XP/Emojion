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
    
    private let EntryDateFormatter: DateFormatter = {
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
                    Text(date, formatter: EntryDateFormatter)
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
                    Text(feelingFinderStore.GetTertiarySelectedFeelingName(feelingArray: feeling))
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
        let viewContext = PersistenceController.preview.container.viewContext
        let entry = Entry(context: viewContext)
        let mock = MockDataObject.restoreEntry(originalEntry: entry, clonedEntry: MockDataObject.entry)

        return EntryListCardView(entry: mock)

//        static let newEntry = Entry(id: UUID(), timestamp: Date(), event: "Public Speaking", emojion: "😬", feeling: "Nervous", rating: "⭐️⭐️⭐️", note: "Coffee helped anxeity")

//        let ent: Entry =
//        {
//            let newEntry = Entry()
//        newEntry.id = UUID()
//        newEntry.timestamp = Date()
//        newEntry.event = "Public Speaking"
//        newEntry.emojion = "😬"
//        newEntry.feeling = "Nervous"
//        newEntry.rating = "⭐️⭐️⭐️"
//        newEntry.note = "Coffee helped anxeity"
//            return newEntry
//        }()
        
//        EntryListCardView(entry: PersistenceController.preview.container.viewContext.registeredObjects.first(where: { $0 is Entry }) as! Entry)
    }
}
