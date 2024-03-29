//
//  ChartBarMarkX.swift
//  Emojion
//
//  Created by nabbit on 26/12/2023.
//

import SwiftUI
import Charts

struct ChartBarMarkXView: View {
    @EnvironmentObject var chartStore: ChartStore
    
    var body: some View {
        Chart(chartStore.feelingData, id: \.type) { feeling in
            Plot {
                BarMark(
                    x: .value("Data Size", feeling.count)
                )
                .foregroundStyle(by: .value("Data Category", feeling.type.rawValue))
//                .annotation(position: .overlay, alignment: .center, spacing: 0) {
//                    Text(String(element.count))
//                        .foregroundColor(.white.opacity(1))
//                        .font(.caption)
//                        .fontWeight(.regular)
//                }
            }
        }
        .chartForegroundStyleScale(domain: chartStore.feelingData.compactMap({ feeling in
            feeling.type.rawValue
        }), range: chartStore.feelingColors)
        .chartPlotStyle { plotArea in
            plotArea
                #if os(macOS)
                .background(Color.gray.opacity(0.2))
                #else
                .background(Color(.systemFill))
                #endif
                .cornerRadius(8)
        }
        .chartXAxis(.hidden)
//                    .chartYScale(range: .plotDimension(endPadding: -8))
//                    .chartLegend(position: .bottom, spacing: -8)
        .chartLegend(CanShowChartLegend())
//        .padding(.bottom, 15)
        .frame(height: GetChartLegendSize())
    }
    
    func CanShowChartLegend() -> Visibility {
        if UIDevice.current.name.contains("Pro Max") {
            return .visible
        } else {
            return .hidden
        }
    }
    
    func GetChartLegendSize() -> CGFloat {
        if UIDevice.current.name.contains("Pro Max") {
            return 50
        } else {
            return 30
        }
    }
}
