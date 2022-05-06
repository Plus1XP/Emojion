//
//  FeelingFinderView.swift
//  Emojion
//
//  Created by Plus1XP on 23/04/2022.
//

import SwiftUI

struct FeelingFinderView: View {
    @ObservedObject var store: FeelingFinderStore = FeelingFinderStore()
    @State var refreshView: Bool = false
    @Binding var feeling: [Int]
    
    private var feeling2: Binding<[Int]> {
        Binding<[Int]>(get: {
            return feeling
        }, set: {
            debugPrint("feeling array before selection: \(feeling)")
            NotificationCenter.default.post(name: Notification.Name("RefreshFeelingView"), object: nil)
            feeling = store.ResetArrayChoices(originalArray: feeling, newArray: $0)
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
                    Picker("Select Primary Feeling", selection: feeling2[0]) {
                        ForEach(0 ..< store.feeling.count, id: \.self) {
                            Text(self.store.feeling[$0].name)
                                .foregroundColor(store.feeling[$0].color)
                        }
                    }
                } label: {
                    Text(store.GetPrimarySelectedFeelingName(feelingArray: feeling2.wrappedValue))
                        .foregroundColor(store.GetPrimarySelectedFeelingColor(feelingArray: feeling2.wrappedValue))
                }
                Text(Image(systemName: "2.circle"))
                Menu {
                    Picker("Select Secondary Feeling", selection: feeling2[1]) {
                        ForEach(0 ..< store.GetSecondaryFeelingArray(feelingArray: feeling2.wrappedValue).count, id: \.self) {
                            Text(store.GetSecondaryFeelingArray(feelingArray: feeling2.wrappedValue)[$0].name)
                                .foregroundColor(store.GetSecondaryFeelingArray(feelingArray: feeling2.wrappedValue)[$0].color)
                        }
                    }
                } label: {
                    Text(store.GetSecondarySelectedFeelingName(feelingArray: feeling2.wrappedValue))
                        .foregroundColor(store.GetPrimarySelectedFeelingColor(feelingArray: feeling2.wrappedValue))
                }
                Text(Image(systemName: "3.circle"))
                Menu {
                    Picker("Select Tertiary Feeling", selection: feeling2[2]) {
                        ForEach(0 ..< store.GetTertiaryFeelingArray(feelingArray: feeling2.wrappedValue).count, id: \.self) {
                            Text(store.GetTertiaryFeelingArray(feelingArray: feeling2.wrappedValue)[$0].name)
                                .foregroundColor(store.GetTertiaryFeelingArray(feelingArray: feeling2.wrappedValue)[$0].color)
                        }
                    }
                } label: {
                    Text(store.GetTertiarySelectedFeelingName(feelingArray: feeling2.wrappedValue))
                        .foregroundColor(store.GetPrimarySelectedFeelingColor(feelingArray: feeling2.wrappedValue))
                }
            }
            .font(.system(size: 14))
        }
    }
}

struct FeelingFinderView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingFinderView(feeling: .constant([2,2,0]))
    }
}
