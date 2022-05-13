//
//  FeelingFinderView.swift
//  Emojion
//
//  Created by Plus1XP on 23/04/2022.
//

import SwiftUI

struct FeelingFinderView: View {
    @ObservedObject var feelingFinderStore: FeelingFinderStore = FeelingFinderStore()
    @State var refreshView: Bool = false
    @Binding var feeling: [Int]
    
    private var selectedFeeling: Binding<[Int]> {
        Binding<[Int]>(get: {
            return feeling
        }, set: {
            debugPrint("feeling array before selection: \(feeling)")
            NotificationCenter.default.post(name: Notification.Name("RefreshFeelingView"), object: nil)
            feeling = feelingFinderStore.resetArrayChoices(originalArray: feeling, newArray: $0)
            debugPrint("FeelingFinderView: FeelingView Refreshed")
            refreshView.toggle()
            debugPrint("feeling array after selection: \(feeling)")
        })
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(Image(systemName: "1.circle"))
                Menu {
                    Picker("Select Primary Feeling", selection: selectedFeeling[0]) {
                        ForEach(0 ..< feelingFinderStore.feeling.count, id: \.self) {
                            Text(self.feelingFinderStore.feeling[$0].name)
                                .foregroundColor(feelingFinderStore.feeling[$0].color)
                        }
                    }
                } label: {
                    Text(feelingFinderStore.getPrimarySelectedFeelingName(feelingArray: selectedFeeling.wrappedValue))
//                        .foregroundColor(store.GetPrimarySelectedFeelingColor(feelingArray: feeling2.wrappedValue))
                }
                Text(Image(systemName: "2.circle"))
                Menu {
                    Picker("Select Secondary Feeling", selection: selectedFeeling[1]) {
                        ForEach(0 ..< feelingFinderStore.getSecondaryFeelingArray(feelingArray: selectedFeeling.wrappedValue).count, id: \.self) {
                            Text(feelingFinderStore.getSecondaryFeelingArray(feelingArray: selectedFeeling.wrappedValue)[$0].name)
                                .foregroundColor(feelingFinderStore.getSecondaryFeelingArray(feelingArray: selectedFeeling.wrappedValue)[$0].color)
                        }
                    }
                } label: {
                    Text(feelingFinderStore.getSecondarySelectedFeelingName(feelingArray: selectedFeeling.wrappedValue))
//                        .foregroundColor(store.GetPrimarySelectedFeelingColor(feelingArray: feeling2.wrappedValue))
                }
                Text(Image(systemName: "3.circle"))
                Menu {
                    Picker("Select Tertiary Feeling", selection: selectedFeeling[2]) {
                        ForEach(0 ..< feelingFinderStore.getTertiaryFeelingArray(feelingArray: selectedFeeling.wrappedValue).count, id: \.self) {
                            Text(feelingFinderStore.getTertiaryFeelingArray(feelingArray: selectedFeeling.wrappedValue)[$0].name)
                                .foregroundColor(feelingFinderStore.getTertiaryFeelingArray(feelingArray: selectedFeeling.wrappedValue)[$0].color)
                        }
                    }
                } label: {
                    Text(feelingFinderStore.getTertiarySelectedFeelingName(feelingArray: selectedFeeling.wrappedValue))
//                        .foregroundColor(store.GetPrimarySelectedFeelingColor(feelingArray: feeling2.wrappedValue))
                }
            }
            .font(.system(size: 14))
        }
    }
}

struct FeelingFinderView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingFinderView(feeling: .constant(Entry.MockEntry.feeling!))
            .previewLayout(.sizeThatFits)
    }
}
