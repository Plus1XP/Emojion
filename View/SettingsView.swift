//
//  SettingsView.swift
//  Emojion
//
//  Created by Plus1XP on 26/05/2022.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var entryStore: EntryStore
    @State var isDebugEnabled: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Developer Tools")) {
                Group {
                    HStack {
                        // Causes `kCFRunLoopCommonModes` / `CFRunLoopRunSpecific` error
                        Toggle("Enable Debug Mode", isOn: $isDebugEnabled)
                            .padding([.leading, .trailing])
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                            entryStore.addMockEntries(numberOfEntries: 30)
                        }) {
                            Label("", systemImage: "calendar.badge.plus")
                                .foregroundStyle(.green, .white)
                        }
                        Spacer()
                        Button(action: {
                            entryStore.deleteAllEntries()
                        }) {
                            Label("", systemImage: "calendar.badge.minus")
                                .foregroundStyle(.red, .white)
                        }
                        Spacer()
                        Button(action: {
                            entryStore.resetCoreData()
                        }) {
                            Label("", systemImage: "xmark.octagon.fill")
                                .foregroundStyle(.white, .red)
                        }
                        Spacer()
                    }
                    .disabled(!isDebugEnabled)
                    .opacity(isDebugEnabled ? 1 : 0)
//                    .hidden(!isDebugEnabled)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let entryStore = EntryStore()
        SettingsView(entryStore: entryStore)
    }
}
