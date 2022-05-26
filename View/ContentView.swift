//
//  ContentView.swift
//  Shared
//
//  Created by Plus1XP on 14/04/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var entryStore = EntryStore()
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                EntryListView(entryStore: entryStore)
                    .navigationTitle("Emojions")
            }
            .tabItem {
                Image(systemName: "rectangle.stack")
                Text("Card")
            }
            .tag(0)
            NavigationView {
                CalendarView(calendar: Calendar(identifier: .iso8601))
                    .navigationTitle("Emojions")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Calendar")
            }
            .tag(1)
            NavigationView {
                SettingsView(entryStore: entryStore)
                    .navigationTitle("Settings")
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
            .tag(2)
        }
        // This fixes navigationBarTitle LayoutConstraints issue for NavigationView
        .navigationViewStyle(.stack)
        .environmentObject(entryStore)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
