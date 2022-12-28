//
//  FeelingStatsView.swift
//  Emojion
//
//  Created by nabbit on 28/12/2022.
//

import SwiftUI
import Charts

struct StackedBarChartView: View {
    @ObservedObject var chartStore: ChartStore
    @ObservedObject var entryStore: EntryStore
    
    var body: some View {
        VStack {
            Chart {
                ForEach(chartStore.chartData) { feeling in
                    BarMark(
                        x: .value("Feeling Type", feeling.type),
                        y: .value("Total Count", feeling.count)
                    )
                    .foregroundStyle(by: .value("Feeling Color", feeling.type))
                }
            }
//            .chartForegroundStyleScale([
//                "Green": .green, "Purple": .purple, "Pink": .pink, "Yellow": .yellow
//            ])
            .onAppear(perform: { chartStore.updateFeelingStats(entryStore: entryStore) } )
        }
        .padding()
    }
}

struct StackedBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        let chartStore = ChartStore()
        let entryStore = EntryStore()
        StackedBarChartView(chartStore: chartStore, entryStore: entryStore)
            .previewLayout(.sizeThatFits)
    }
}
