//
//  ChartStore.swift
//  Emojion
//
//  Created by nabbit on 28/12/2022.
//

import SwiftUI

class ChartStore: ObservableObject {
    @Published var chartData = [FeelingStats]()
    @ObservedObject var feelingFinderStore: FeelingFinderStore = FeelingFinderStore()
    
    func updateFeelingStats(entryStore: EntryStore) -> Void {
        chartData = [FeelingStats]()
        for entry in entryStore.entries {
            chartData.append(FeelingStats(color: getPrimarySelectedFeelingColor(feelingArray: entry.feeling!).description, type: getPrimarySelectedFeelingName(feelingArray: entry.feeling!), date: entry.timestamp!, count: 1))
        }
    }
    
    func getFeelingStats(entryStore: EntryStore) -> [FeelingStats] {
        var feelingDictionary: [FeelingStats] = [FeelingStats]()
        for entry in entryStore.entries {
            feelingDictionary.append(FeelingStats(color: getPrimarySelectedFeelingColor(feelingArray: entry.feeling!).description, type: getPrimarySelectedFeelingName(feelingArray: entry.feeling!), date: entry.timestamp!, count: 1))
        }
        return feelingDictionary
    }
    
    func getPrimarySelectedFeelingName(feelingArray: [Int]) -> String {
        if !feelingArray.isEmpty {
            return feelingFinderStore.feeling[feelingArray[0]].name.capitalized
        } else {
            return ""
        }
    }

    func getPrimarySelectedFeelingColor(feelingArray: [Int]) -> Color {
        if !feelingArray.isEmpty {
            return feelingFinderStore.feeling[feelingArray[0]].color
        } else {
            return Color.primary
        }
    }
}
