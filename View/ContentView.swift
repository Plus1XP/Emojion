//
//  ContentView.swift
//  Shared
//
//  Created by Plus1XP on 14/04/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var entryStore = EntryStore()
    @StateObject private var calendarStore = CalendarStore()
    @StateObject private var chartStore = ChartStore()
    @ObservedObject var biometricStore: BiometricStore
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                CardView(entryStore: entryStore)
                    .navigationTitle("Emojions")
            }
            .tabItem {
                Image(systemName: "rectangle.stack")
                Text("Card")
            }
            .tag(0)
            NavigationView {
                CalendarView(calendarStore: calendarStore, entryStore: entryStore, calendar: Calendar(identifier: .iso8601))
                    .navigationTitle("Emojions")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Calendar")
            }
            .tag(1)
            NavigationView {
                ChartView(chartStore: chartStore, entryStore: entryStore)
                    .navigationTitle("Emojions")
            }
            .tabItem {
                Image(systemName: "chart.bar.xaxis")
                Text("Chart")
            }
            .tag(2)
            NavigationView {
                SettingsView(entryStore: entryStore, biometricStore: biometricStore)
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
        let biometricStore = BiometricStore()
        ContentView(biometricStore: biometricStore)
            .preferredColorScheme(.dark)
        ContentView(biometricStore: biometricStore)
            .preferredColorScheme(.light)
    }
}
