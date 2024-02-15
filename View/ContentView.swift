//
//  ContentView.swift
//  Shared
//
//  Created by Plus1XP on 14/04/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var entryStore: EntryStore
    @EnvironmentObject private var calendarStore: CalendarStore
    @EnvironmentObject private var chartStore: ChartStore
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                CardView()
                    .navigationTitle("Emojions")
            }
            .tabItem {
                Image(systemName: "rectangle.stack")
                Text("Emojions")
            }
            .tag(0)
            NavigationView {
                CalendarView(calendar: Calendar(identifier: .iso8601))
                    .navigationTitle("Calendar")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Calendar")
            }
            .tag(1)
            NavigationView {
                ChartView()
                    .navigationTitle("Insights")
            }
            .tabItem {
                Image(systemName: "chart.bar.xaxis")
                Text("Insights")
            }
            .tag(2)
            NavigationView {
                SettingsView()
                    .navigationTitle("Settings")
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
            .tag(3)
        }
        // This fixes navigationBarTitle LayoutConstraints issue for NavigationView
        .navigationViewStyle(.stack)
        .environmentObject(entryStore)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(EntryStore())
            .environmentObject(CalendarStore())
            .environmentObject(ChartStore())
            .preferredColorScheme(.dark)
        ContentView()
            .environmentObject(EntryStore())
            .environmentObject(CalendarStore())
            .environmentObject(ChartStore())
            .preferredColorScheme(.light)
    }
}
