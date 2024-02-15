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
    @State var chartsNew = [FeelingData]()
    
    var orders: [Order] = [
            Order(amount: 10, day: 1),
            Order(amount: 7, day: 2),
            Order(amount: 4, day: 3),
            Order(amount: 13, day: 4),
            Order(amount: 19, day: 5),
            Order(amount: 6, day: 6),
            Order(amount: 16, day: 7)
        ]
    
    var dict = [String:Int]()
    
    var body: some View {
        VStack {
            
            Chart {
                ForEach(chartStore.chartData) { feeling in
//                    Plot {
                        BarMark(
                            x: .value("Feeling Type", feeling.type),
                            y: .value("Total Count", feeling.date)
                        )

//                    }
                    .foregroundStyle(by: .value("Feeling Color", feeling.type))

//                        .foregroundStyle(by: .value("Pet type", feeling.date))
//                    .symbol(by: .value("Pet type", feeling.color))
//                    .annotation(position: .trailing) {
//                        Text(String(feeling.count))
//                            .foregroundColor(.gray)
//                    }
                }

            }
            .chartLegend(.hidden)

            Chart {
                ForEach(chartStore.chartData) { feeling in
//                    Plot {
                        BarMark(
                            x: .value("Feeling Type", feeling.type),
                            y: .value("Total Count", feeling.count)
                        )
//                    }
//                    .foregroundStyle(by: .value("Feeling Color", feeling.type))
                        .foregroundStyle(by: .value("Pet type", feeling.date))
//                    .symbol(by: .value("Pet type", feeling.color))
//                    .annotation(position: .trailing) {
//                        Text(String(feeling.count))
//                            .foregroundColor(.gray)
//                    }
                }
            }
            
            
//            Chart {
//                ForEach(chartStore.chartData, id:\.date) { feeling in
////                    Plot {
//                        BarMark(
//                            x: .value("Feeling Type", feeling.type),
//                            y: .value("Total Count", feeling.count)
//                        )
////                    }
//                    .foregroundStyle(by: .value("Feeling Color", feeling.type))
////                        .foregroundStyle(by: .value("Pet type", feeling.date))
////                    .symbol(by: .value("Pet type", feeling.color))
////                    .annotation(position: .trailing) {
////                        Text(String(feeling.count))
////                            .foregroundColor(.gray)
////                    }
//                }
//            }
//            .aspectRatio(1, contentMode: .fit)
//                    .padding()
//            .chartLegend(.hidden)
//            .chartXAxis(.hidden)
//            .chartYAxis {
//                AxisMarks(values: .automatic(desiredCount: 10))
//            }
//            .chartXAxis{
//                AxisMarks {
//                    AxisGridLine(stroke: StrokeStyle(lineWidth: 2))
//                    AxisTick(stroke: StrokeStyle(lineWidth: 2))
//                    AxisValueLabel(anchor: .bottomTrailing)
//                }
//            }
//            .chartYAxis {
//                AxisMarks { _ in
//                    AxisValueLabel()
//                }
//            }
//            .chartForegroundStyleScale([
//                "Green": .green, "Purple": .purple, "Pink": .pink, "Yellow": .yellow
//            ])
            .onAppear(perform: {
//                chartStore.updateFeelingStats(entryStore: entryStore)
//                chartsNew = entryStore.getPrimaryStats3()
//                print(entryStore.getPrimaryStats2())
            } )
//            .hidden(true)
//
            
            Chart(chartsNew, id: \.type) { element in
                Plot {
                    BarMark(
                        x: .value("Data Size", element.count)
                    )
                    .foregroundStyle(by: .value("Data Category", element.type))
                }
                .accessibilityLabel(element.type)
                .accessibilityValue("\(element.count) Emojions")
//                .accessibilityHidden(isOverview)
            }
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
//            .accessibilityChartDescriptor(self)
//            .chartXScale(range: 0...128)
//            .chartYScale(range: .plotDimension(endPadding: -8))
//            .chartLegend(position: .bottom, spacing: -8)
            .chartLegend(.visible)
            .frame(height: 50)
            
            Chart{
//                let sum1 = chartStore.chartData.sum(of: \.type).keys
//                let crossReference = Dictionary(grouping: chartStore.chartData, by: \.type)
//                let duplicates = crossReference
//                    .filter { $1.count > 1 }
                
                
                
                ForEach(chartsNew, id: \.id) { tup in

                    LineMark(
                        x: .value("Feeling Type", tup.type ),
                        y: .value("Total Count", tup.count)
                    )
//                    .annotation(position: .trailing) {
//                        Text(tup.count.description)
//                            .font(.caption)
//                    }
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
                        x: .value("Feeling Type", tup.type),
                        y: .value("Total Count", tup.count)
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
//            .chartYScale(domain: [0, 100])
            
//            
//            Chart{
//                ForEach(chartsNew, id: \.id) { tup in
//
//                    BarMark(
//                        x: .value("Feeling Type", tup.type ),
//                        y: .value("Total Count", tup.count)
//                    )
////                    .annotation(position: .overlay) {
////                        Text(tup.count.description)
////                            .font(.caption)
////                    }
//
//                }
//
//            }
//            
            Chart(chartsNew, id: \.id) { dataItem in
                SectorMark(
                    angle: .value("Type", dataItem.count),
                                   innerRadius: .ratio(0.5),
                                   angularInset: 1.5)
                            .cornerRadius(5)
                            .foregroundStyle(by: .value("Type", dataItem.type))
//                            .annotation(position: .overlay)
//                {
//                    Text(dataItem.count.description)
//                }//                            .opacity(dataItem.type == "Sad" ? 1 : 0.5)
                    }
//                    .frame(height: 200)
            
            
            .onAppear(perform: {
//                chartsNew = entryStore.getPrimaryStats3()
//                
//                print(chartsNew)
////                let newcount = chartStore.chartData.type.map { $0.count }
////                debugPrint(newcount.count)
//                let sum1 = chartStore.chartData.sum(of: \.type)
//                print(sum1)
//                let crossReference = Dictionary(grouping: chartStore.chartData, by: \.type)
//                print(crossReference)
//                let duplicates = crossReference
//                    .filter { $1.count > 1 }
//                print(duplicates)
                
//                print(entryStore.getPrimaryStats2())
                
//                for item in chartStore.chartData {
//                    ForEach(item.type) { name in
//                        if !dict.keys.contains(name) {
//                            dict = [name:1]
//                        } else {
//                            ForEach(name) { count in
//                                dict[name].append(1)
//                            }
//                        }
//                    }
//                }

            } )

//            Chart {
//                ForEach(orders) { order in
//                    LineMark(
//                        x: PlottableValue.value("Month", order.day),
//                        y: PlottableValue.value("Orders", order.amount)
//                    )
//                }
//            }
            
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

struct Order: Identifiable {
    var id: String = UUID().uuidString
    var amount: Int
    var day: Int
}
