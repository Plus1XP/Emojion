//
//  FeelingFinderView.swift
//  Emojion
//
//  Created by Plus1XP on 23/04/2022.
//

import SwiftUI

struct FeelingFinderView: View {
    @ObservedObject var store = FeelingFinderStore()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(Image(systemName: "1.circle"))
                Menu {
                    Picker("Select Primary Feeling", selection: $store.primaryFeelingSelected) {
                        ForEach(0 ..< store.feeling.count, id: \.self) {
                            Text(self.store.feeling[$0].name)
                                .foregroundColor(store.feeling[$0].color)
                        }
                    }
                } label: {
                    Text(store.GetPrimarySelectedFeelingName())
                        .foregroundColor(store.GetPrimarySelectedFeelingColor())
                }
                Text(Image(systemName: "2.circle"))
                Menu {
                    Picker("Select Secondary Feeling", selection: $store.secondaryFeelingSelected) {
                        ForEach(0 ..< store.GetSecondaryFeelingArray().count, id: \.self) {
                            Text(store.GetSecondaryFeelingArray()[$0].name)
                                .foregroundColor(store.GetSecondaryFeelingArray()[$0].color)
                        }
                    }
                } label: {
                    Text(store.GetSecondarySelectedFeelingName())
                        .foregroundColor(store.GetPrimarySelectedFeelingColor())
                }
                Text(Image(systemName: "3.circle"))
                Menu {
                    Picker("Select Tertiary Feeling", selection: $store.tertiaryFeelingSelected) {
                        ForEach(0 ..< store.GetTertiaryFeelingArray().count, id: \.self) {
                            Text(store.GetTertiaryFeelingArray()[$0].name)
                                .foregroundColor(store.GetTertiaryFeelingArray()[$0].color)
                        }
                    }
                } label: {
                    Text(store.GetTertiarySelectedFeelingName())
                        .foregroundColor(store.GetPrimarySelectedFeelingColor())
                }
            }
            .font(.system(size: 14))
        }
    }
}

struct FeelingFinderView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingFinderView()
    }
}
