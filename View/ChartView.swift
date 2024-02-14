//
//  ChartView.swift
//  Emojion
//
//  Created by Plus1XP on 06/06/2022.
//

import SwiftUI

struct ChartView: View {
    @EnvironmentObject var chartStore: ChartStore
    @EnvironmentObject var entryStore: EntryStore
    
    var body: some View {
//    ToDo: Add multiple chart views
        StackedBarChartView(chartStore: chartStore, entryStore: entryStore)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
            .environmentObject(EntryStore())
            .environmentObject(ChartStore())
    }
}
