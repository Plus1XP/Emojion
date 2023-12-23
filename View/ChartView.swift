//
//  ChartView.swift
//  Emojion
//
//  Created by Plus1XP on 06/06/2022.
//

import SwiftUI

struct ChartView: View {
    @ObservedObject var chartStore: ChartStore
    @ObservedObject var entryStore: EntryStore
    
    var body: some View {
//    ToDo: Add multiple chart views
        StackedBarChartView(chartStore: chartStore, entryStore: entryStore)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        let chartStore = ChartStore()
        let entryStore = EntryStore()
        ChartView(chartStore: chartStore, entryStore: entryStore)
    }
}
