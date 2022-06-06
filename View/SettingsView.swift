//
//  SettingsView.swift
//  Emojion
//
//  Created by Plus1XP on 26/05/2022.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var entryStore: EntryStore
    @State var isFaceidEnabled: Bool = false
    @State var isIcloudEnabled: Bool = false
    
    // Fill in App ID when app is added to appstore connect!
    let appID: String = ""
    let mailURL: String = "mailto:evlbrains@protonmail.ch"
    let twitterURL: String = "https://twitter.com/evlbrains"
    let appURL: String = "https://apps.apple.com/us/app/id"
    let reviewForwarder: String = "?action=write-review"
    let githubURL: String = "https://github.com/Plus1XP"


    
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
                        Toggle("Enable Face ID", isOn: $isFaceidEnabled)
                            .padding([.leading, .trailing])
                            .disabled(true)
                    }
                }
            }
            Section(header: Text("\(Image(systemName: "clock.arrow.circlepath")) Backup")) {
                Group {
                    HStack {
                        Image(systemName: "icloud.fill")
                            .foregroundStyle(.gray)
                        // Causes `kCFRunLoopCommonModes` / `CFRunLoopRunSpecific` error
                        Toggle("iCloud", isOn: $isIcloudEnabled)
                            .padding([.leading, .trailing])
                            .disabled(true)
                    }
                }
            }
            Section(header: Text("\(Image(systemName: "message")) FeedBack")) {
                Group {
                    HStack {
                        Link(destination: URL(string: mailURL)!) {
                            HStack {
                                Image(systemName: "paperplane.fill")
                                    .foregroundStyle(.blue)
                                Text("Email")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    HStack {
                        Link(destination: URL(string: twitterURL)!) {
                            HStack {
                                Image(systemName: "quote.bubble.fill")
                                    .foregroundStyle(.blue)
                                Text("Tweet")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    HStack {
                        Button {
                            let AV = UIActivityViewController(activityItems: [appURL+appID], applicationActivities: nil)
                            let scenes = UIApplication.shared.connectedScenes
                            let windowScene = scenes.first as? UIWindowScene
                            windowScene?.keyWindow?.rootViewController?.present(AV, animated: true, completion: nil)
                        } label: {
                            HStack {
                                Image(systemName: "arrowshape.turn.up.forward.fill")
                                    .foregroundStyle(.blue)
                                Text("Share")
                                    .foregroundColor(.primary)
                            }
                        }
                        .disabled(true)
                    }
                    HStack {
                        Link(destination: URL(string: appURL+appID+reviewForwarder)!) {
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                                Text("Rate")
                                    .foregroundColor(.primary)
                            }
                        }
                        .disabled(true)
                    }
                }
            }
            Section(header: Text("\(Image(systemName: "info.circle")) About")) {
                Group {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.black, .yellow)
                        Text("Version \(versionString)")
                    }
                    HStack {
                        Link(destination: URL(string: githubURL)!) {
                            HStack {
                                Image(systemName: "paintbrush.fill")
                                    .foregroundStyle(.orange)
                                Text("Designed by Plus1XP")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    HStack {
                        Link(destination: URL(string: githubURL)!) {
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
                        Text("Copyright 2022 Plus1XP")
                    }
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
