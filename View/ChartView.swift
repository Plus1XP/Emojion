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
    @State private var selection = 1
    
    @State var replay: Bool = true

    var body: some View {
//    ToDo: Add multiple chart views
//        StackedBarChartView(chartStore: chartStore, entryStore: entryStore)
        VStack{
            TabView(selection: $selection) {
                ChartBarMarkDateView()
                .tag(0)
                ChartLineMarkView()
                    .onDisappear(perform: {
                        if self.selection != 2 {
                            self.selection = 4
                        }
                    })
                .tag(1)
                ChartBarMarkXYView()
                .tag(2)
                ChartSectorMarkView()
                .tag(3)
                ChartBarMarkDateView()
                    .onDisappear(perform: {
                        if self.selection != 3 {
                            self.selection = 1
                        }
                    })
                .tag(4)
                ChartLineMarkView()
                .tag(5)
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
        .onAppear(perform: {
            chartStore.fetchAll(entries: entryStore.entries)

        })
        .refreshable {
            chartStore.fetchAll(entries: entryStore.entries)
        }
        .background(colorScheme == .light ? Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground))
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
            .environmentObject(EntryStore())
            .environmentObject(ChartStore())
    }
}
