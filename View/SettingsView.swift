//
//  SettingsView.swift
//  Emojion
//
//  Created by Plus1XP on 26/05/2022.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var entryStore: EntryStore
    @ObservedObject var biometricStore: BiometricStore
    @ObservedObject var syncMonitor: SyncMonitor = SyncMonitor.shared
    @State var canShowSyncError: Bool = false
    // Fill in App ID when app is added to appstore connect!
    let appName: String = "Emojion App"
    let appID: String = "1628565468"
    let mailURL: String = "mailto:evlbrains@protonmail.ch"
    let supportURL: String = "https://plus1xp.github.io/emojion/"
    let githubURL: String = "https://github.com/Plus1XP"
    let appURL: String = "https://apps.apple.com/us/app/id"
    let reviewForwarder: String = "?action=write-review"


    
    private let versionString: String = {
            let version: String = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "_error"
            let build: String = (Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? "_error"
            return version + " (" + build + ")"
    }()
    
    var body: some View {
        Form {
            Section(header: Text("\(Image(systemName: "lock")) Security")) {
                Group {
                    HStack {
                        Image(systemName: "faceid")
                            .foregroundStyle(.green)
                        // Causes `kCFRunLoopCommonModes` / `CFRunLoopRunSpecific` error
                        Toggle("Enable Face ID", isOn: $biometricStore.isFaceidEnabled)
                            .padding([.leading, .trailing])
                            .onChange(of: self.biometricStore.isFaceidEnabled,
                            {
                                let selectionFeedback = UISelectionFeedbackGenerator()
                                selectionFeedback.selectionChanged()
                                if self.biometricStore.isFaceidEnabled {
                                    self.biometricStore.ValidateBiometrics()
                                } else {
                                    self.biometricStore.isAutoLockEnabled = false
                                }
                            })
                    }
                    HStack {
                        Image(systemName: "lock.badge.clock")
                            .foregroundStyle(.red)
                        // Causes `kCFRunLoopCommonModes` / `CFRunLoopRunSpecific` error
                        Toggle("Enable Auto-Lock", isOn: $biometricStore.isAutoLockEnabled)
                            .padding([.leading, .trailing])
                            .onChange(of: self.biometricStore.isAutoLockEnabled,
                            {
                                let selectionFeedback = UISelectionFeedbackGenerator()
                                selectionFeedback.selectionChanged()
                            })
                            .disabled(!self.biometricStore.isFaceidEnabled)
                    }
                }
            }
            Section(content: {
                HStack {
                    Image(systemName: self.syncMonitor.syncStateSummary.symbolName)
                        .foregroundColor(self.syncMonitor.syncStateSummary.symbolColor)
                    Text("iCloud Sync Status")
                    Spacer()
                    Button {
                        let feedbackGenerator: UINotificationFeedbackGenerator? = UINotificationFeedbackGenerator()
                        feedbackGenerator?.notificationOccurred(.error)
                        self.canShowSyncError.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "info.circle")
                        }
                    }
                    .foregroundStyle(SyncMonitor.shared.syncError || SyncMonitor.shared.notSyncing ? .blue : .gray)
                    .disabled(SyncMonitor.shared.syncError || SyncMonitor.shared.notSyncing  ? false : true)
                }
                if self.canShowSyncError {
                    VStack {
                        HStack {
                            Group {
                                if self.syncMonitor.syncError {
                                    VStack {
                                        HStack {
                                            if self.syncMonitor.setupError != nil {
                                                Image(systemName: "xmark.icloud").foregroundColor(.red)
                                            }
                                            if self.syncMonitor.importError != nil {
                                                Image(systemName: "icloud.and.arrow.down").foregroundColor(.red)
                                            }
                                            if self.syncMonitor.exportError != nil {
                                                Image(systemName: "icloud.and.arrow.up").foregroundColor(.red)
                                            }
                                        }
                                    }
                                } else if self.syncMonitor.notSyncing {
                                    Image(systemName: "xmark.icloud")
                                } else {
                                    Image(systemName: "icloud").foregroundColor(.green)
                                }
                            }
                        }
                        .padding(.bottom)
                        VStack(spacing: 10) {
                            if SyncMonitor.shared.syncError {
                                if let e = SyncMonitor.shared.setupError {
                                    Text("Unable to set up iCloud sync, changes won't be saved! \(e.localizedDescription)")
                                }
                                if let e = SyncMonitor.shared.importError {
                                    Text("Import is broken: \(e.localizedDescription)")
                                }
                                if let e = SyncMonitor.shared.exportError {
                                    Text("Export is broken - your changes aren't being saved! \(e.localizedDescription)")
                                }
                            } else if SyncMonitor.shared.notSyncing {
                                Text("Sync should be working, but isn't. Look for a badge on Settings or other possible issues.")
                            }
                        }
                    }
                }
            }, header: {
                Text("\(Image(systemName: "clock.arrow.circlepath")) Backup")
            }, footer: {
                Text("")
            })
            Section(header: Text("\(Image(systemName: "message")) FeedBack")) {
                Group {
                    HStack {
                        Link(destination: URL(string: self.mailURL)!) {
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundStyle(.blue)
                                Text("Get in Touch")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    HStack {
                        Link(destination: URL(string: self.supportURL)!) {
                            HStack {
                                Image(systemName: "safari")
                                    .foregroundStyle(.red, .blue)
                                    .font(.title2)
                                Text("Discover More")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    HStack {
                        ShareLink(
                            item: URL(string: self.appURL + self.appID)!,
                            preview: SharePreview( self.appName,
                            image: Image(uiImage: UIImage(named: "AppIcon60x60") ?? UIImage())
                            )
                        ) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundStyle(.blue)
                                    .font(.title2)
                                Text("Share with Friends")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    HStack {
                        Link(destination: URL(string: self.appURL + self.appID + self.reviewForwarder)!) {
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                                    .font(.title3)
                                Text("Rate and Review")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
            }
            Section(header: Text("\(Image(systemName: "info.circle")) About")) {
                Group {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.black, .yellow)
                        Text("Version \(self.versionString)")
                    }
                    HStack {
                        Link(destination: URL(string: self.githubURL)!) {
                            HStack {
                                Image(systemName: "paintbrush.fill")
                                    .foregroundStyle(.green)
                                Text("Designed by Plus1XP")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    HStack {
                        Link(destination: URL(string: self.githubURL)!) {
                            HStack {
                                Image(systemName: "hammer.fill")
                                    .foregroundStyle(.gray)
                                Text("Developed by Plus1XP")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    HStack {
                        Image(systemName: "c.circle")
                            .foregroundStyle(.primary)
                        Text("Copyright 2023 Plus1XP")
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let entryStore = EntryStore()
        let biometricStore = BiometricStore()
        SettingsView(entryStore: entryStore, biometricStore: biometricStore)
    }
}
