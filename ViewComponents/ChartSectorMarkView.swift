//
//  ChartSectorMark.swift
//  Emojion
//
//  Created by nabbit on 26/12/2023.
//

import SwiftUI
import Charts

struct ChartSectorMarkView: View {
    @EnvironmentObject var chartStore: ChartStore
    
    var body: some View {
        Chart(chartStore.feelingData, id: \.id) { feeling in
            SectorMark(
                angle: .value("Type", feeling.count),
                innerRadius: .ratio(0.2),
                angularInset: 1.5)
            .cornerRadius(5)
            .foregroundStyle(by: .value("Type", feeling.type))
        }
        .chartLegend(.hidden)
        .chartForegroundStyleScale(domain: chartStore.feelingData.compactMap({ feeling in
            feeling.type
        }), range: chartStore.feelingColors)
        .padding(.top, 5)
    }
}
