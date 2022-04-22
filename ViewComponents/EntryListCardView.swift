//
//  EntryCardView.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import SwiftUI

struct EntryListCardView: View {
    @State var entry: Entry
    var starFontSize: CGFloat = 14.5
    var emojionFontSize: CGFloat = 55
    
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
                //Text((entry.emojion == "" ? "🫥" : entry.emojion)!)
                //.font(.headline)
                let emojionEmoji = (entry.emojion == "" || entry.emojion == nil ? "🫥" : entry.emojion)!.ToImage(fontSize: emojionFontSize)
                Image(uiImage: emojionEmoji!)
//                    .resizable()
                // frame size is off to to image extension.
//                    .frame(width: 50, height: 50)
                Spacer()
                VStack {
//                    if let rating = entry.rating {
//                        Text(entry.rating)
//                    }
                    StarRatingView($entry.rating, starFontSize)
                }
                Spacer()
            }
            HStack {
                if let feeling = entry.feeling {
                    Text(feeling)
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

//        EntryListCardView(entry: entry)
        
        entry.id = UUID()
        entry.timestamp = Date()
        entry.event = "Public Speaking"
        entry.emojion = "😬"
        entry.feeling = "Nervous"
        entry.rating = 3
        entry.note = "Coffee helped anxeity"
        
        return EntryListCardView(entry: entry)
        
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
        
//        Entry(id: UUID(), )
        
//        EntryListCardView(entry: entry)
        
//        EntryListCardView(entry: PersistenceController.preview.container.viewContext.registeredObjects.first(where: { $0 is Entry }) as! Entry)
    }
}
