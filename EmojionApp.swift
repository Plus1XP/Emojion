//
//  EmojionApp.swift
//  Shared
//
//  Created by Plus1XP on 14/04/2022.
//

import SwiftUI

@main
struct EmojionApp: App {
    @StateObject private var entryStore = EntryStore()
    @StateObject private var feelingFinderStore = FeelingFinderStore()
    @StateObject private var calendarStore = CalendarStore()
    @StateObject private var chartStore = ChartStore()
    @StateObject private var biometricStore = BiometricStore()
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            AuthenticationView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(self.entryStore)
                .environmentObject(self.feelingFinderStore)
                .environmentObject(self.calendarStore)
                .environmentObject(self.chartStore)
                .environmentObject(self.biometricStore)
        }
    }
}
