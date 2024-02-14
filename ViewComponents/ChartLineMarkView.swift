//
//  ChartLineMark.swift
//  Emojion
//
//  Created by nabbit on 26/12/2023.
//

import SwiftUI
import Charts

struct ChartLineMarkView: View {
    @EnvironmentObject var chartStore: ChartStore
    
    var body: some View {
        Chart{
            ForEach(chartStore.feelingData, id: \.id) { feeling in
                LineMark(
                    x: .value("Feeling Type", feeling.type ),
                    y: .value("Total Count", feeling.count)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(Color.blue)
                .lineStyle(StrokeStyle(lineWidth: 1.5))
                .symbol() {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 10)
                }
                .symbolSize(15)
                AreaMark(
                    x: .value("Feeling Type", feeling.type),
                    y: .value("Total Count", feeling.count)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(LinearGradient(
                    gradient: Gradient (
                        colors: [
                            Color(.blue).opacity(0.5),
                            Color(.blue).opacity(0.2),
                            Color(.blue).opacity(0.05),
                        ]
                    ),
                    startPoint: .top,
                    endPoint: .bottom
                ))
            }
        }
        .padding(.top, 5)
    }
}
