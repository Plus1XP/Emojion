//
//  EntryDebugButtons.swift
//  Emojion
//
//  Created by nabbit on 21/02/2024.
//

import SwiftUI

struct EntryDebugButtons: View {
    @EnvironmentObject var entryStore: EntryStore
    @State private var canShowDebugMenu: Bool = false

    var body: some View {
        Button(action: {
            self.canShowDebugMenu.toggle()
        }) {
            Label("Show Debug Menu", systemImage: canShowDebugMenu ? "chevron.down.circle.fill" : "chevron.down.circle")
                .foregroundStyle(.primary)
        }
        .popover(isPresented: $canShowDebugMenu) {
            HStack {
                Button(action: {
                    entryStore.addTestFlightMockEntries()
                }) {
                    Label("", systemImage: "swift")
                        .foregroundStyle(.orange, .primary)
                }
                Button(action: {
                    entryStore.addRandomMockEntries(numberOfEntries: 30)
                }) {
                    Label("", systemImage: "calendar.badge.plus")
                        .foregroundStyle(.green, .primary)
                }
                Button(action: {
                    entryStore.deleteAllEntries()
                }) {
                    Label("", systemImage: "calendar.badge.minus")
                        .foregroundStyle(.red, .primary)
                }
                Button(action: {
                    entryStore.resetCoreData()
                }) {
                    Label("", systemImage: "xmark.icloud.fill")
                        .foregroundStyle(.white, .red)
                }
                Button(action: {
                    entryStore.addAllMockFeelings()
                }) {
                    Label("", systemImage: "checkmark.seal.fill")
                        .foregroundStyle(.white, .blue)
                }
                Button(action: {
                    FeelingWheelUpdateV22(entries: entryStore.entries)
                }) {
                    Label("", systemImage: "exclamationmark.triangle.fill")
                        .foregroundStyle(.white, .yellow)
                }
            }
            .presentationCompactAdaptation(.popover)
            .frame(minWidth: 100, maxHeight: 50)
            .padding()
            .background(.ultraThinMaterial)
        }
    }
}

#Preview {
    HStack {
        EntryDebugButtons()
    }
    .environmentObject(EntryStore())
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
