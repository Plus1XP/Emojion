//
//  EmojionApp.swift
//  Shared
//
//  Created by Plus1XP on 14/04/2022.
//

import SwiftUI

@main
struct EmojionApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
