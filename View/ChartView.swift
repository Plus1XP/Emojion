//
//  ChartView.swift
//  Emojion
//
//  Created by Plus1XP on 06/06/2022.
//

import SwiftUI

struct ChartView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var chartStore: ChartStore
    @EnvironmentObject var entryStore: EntryStore
    @State private var chartViewSelection = 1
    
    var body: some View {
//    ToDo: Add multiple chart views
        VStack{
            TabView(selection: $chartViewSelection) {
                ChartSectorMarkView()
                    .tag(0)
                ChartLineMarkView()
                    .onDisappear(perform: {
                        if self.chartViewSelection != 2 {
                            self.chartViewSelection = 3
                        }
                    })
                    .tag(1)
                ChartBarMarkXYView()
                    .tag(2)
                ChartSectorMarkView()
                    .onDisappear(perform: {
                        if self.chartViewSelection != 2 {
                            self.chartViewSelection = 1
                        }
                    })
                    .tag(3)
                ChartLineMarkView()
                    .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .padding([.leading, .trailing, .bottom], 20)
            
            HStack {
                ChartStatsView()
                    .background(colorScheme == .light ? .white : Color(UIColor.secondarySystemBackground))
            }
            .border(colorScheme == .light ? .white : Color(UIColor.secondarySystemBackground))
            .cornerRadius(15)
            .shadow(color: colorScheme == .light ? .gray.opacity(0.4) : .white.opacity(0.4), radius: 2)            
            .padding([.leading, .trailing], 20)
            
            ChartBarMarkXView()
                .padding([.leading, .trailing], 20)
        }
        .navigationBarItems(
            trailing:
                HStack {
                    Picker("Chart TimeFrame", selection: $chartStore.chartTimeFrameSelection, content: {
                        Text(ChartTimeFrame.Today.rawValue).tag(ChartTimeFrame.Today)
                        Text(ChartTimeFrame.Yesterday.rawValue).tag(ChartTimeFrame.Yesterday)
                        Text(ChartTimeFrame.Week.rawValue).tag(ChartTimeFrame.Week)
                        Text(ChartTimeFrame.Month.rawValue).tag(ChartTimeFrame.Month)
                        Text(ChartTimeFrame.Year.rawValue).tag(ChartTimeFrame.Year)
                        Text(ChartTimeFrame.All.rawValue).tag(ChartTimeFrame.All)
                    })
                    .pickerStyle(.inline)
                    .onChange(of: chartStore.chartTimeFrameSelection, {
                        chartStore.fetchAll(entries: entryStore.entries)
                    })
                }
        )
        .onAppear(perform: {
            chartStore.fetchAll(entries: entryStore.entries)

        })
        .refreshable {
            chartStore.fetchAll(entries: entryStore.entries)
        }
        .background(Color.setViewBackgroundColor(colorScheme: colorScheme))
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
            .environmentObject(EntryStore())
            .environmentObject(ChartStore())
    }
}
