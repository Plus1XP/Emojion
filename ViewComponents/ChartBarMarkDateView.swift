//
//  ChartBarMarkDate.swift
//  Emojion
//
//  Created by nabbit on 26/12/2023.
//

import SwiftUI
import Charts

struct ChartBarMarkDateView: View {
    @EnvironmentObject var entryStore: EntryStore
    @EnvironmentObject var chartStore: ChartStore
    @State var chartData = [FeelingStats]()
    
    var body: some View {
        Chart {
            ForEach(chartData) { feeling in
                    BarMark(
                        x: .value("Feeling Type", feeling.type),
                        y: .value("Feeling Count", feeling.date)
                    )
                .foregroundStyle(by: .value("Feeling Type", feeling.type))
            }

        }
        .chartForegroundStyleScale(domain: chartStore.feelingData.compactMap({ feeling in
            feeling.type
        }), range: chartStore.feelingColors)
        .chartLegend(.hidden)
        .padding(.top, 5)
        .onAppear(perform: {
            self.chartData = chartStore.updateFeelingStats(entryStore: entryStore)
        })
    }
}
