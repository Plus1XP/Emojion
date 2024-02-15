//
//  ChartBarMarkXY.swift
//  Emojion
//
//  Created by nabbit on 26/12/2023.
//

import SwiftUI
import Charts

struct ChartBarMarkXYView: View {
    @EnvironmentObject var chartStore: ChartStore
    
    var body: some View {
        Chart {
            ForEach(chartStore.feelingData) { feeling in
                    BarMark(
                        x: .value("Feeling Type", feeling.type),
                        y: .value("Total Count", feeling.count)
                    )
                    .foregroundStyle(LinearGradient(
                        gradient: Gradient (
                            colors: [
                                Color(.blue).opacity(1),
                                Color(.blue).opacity(0.8),
                                Color(.blue).opacity(0.6),
                                Color(.blue).opacity(0.5),
                                Color(.blue).opacity(0.3),
                                Color(.blue).opacity(0.2),
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
