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
    
    var body: some View {
        NavigationView {
            EntryListView(entryStore: entryStore)
        }
        // This fixes navigationBarTitle LayoutConstraints issue
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
