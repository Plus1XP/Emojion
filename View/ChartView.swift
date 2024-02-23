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
    
    var body: some View {
//    ToDo: Add multiple chart views
        VStack{
            TabView(selection: $selection) {
                ChartSectorMarkView()
                    .tag(0)
                ChartLineMarkView()
                    .onDisappear(perform: {
                        if self.selection != 2 {
                            self.selection = 3
                        }
                    })
                    .tag(1)
                ChartBarMarkXYView()
                    .tag(2)
                ChartSectorMarkView()
                    .onDisappear(perform: {
                        if self.selection != 2 {
                            self.selection = 1
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
