//
//  StarRatingUpdateV22.swift
//  Emojion
//
//  Created by nabbit on 27/02/2024.
//

import SwiftUI

struct StarRatingUpdateV22 {
    @AppStorage("hasRunStarRatingV22Update") var hasRunV22Update: Bool = false
    var entries: [Entry]
    
    init(entries: [Entry]) {
        self.entries = entries
        RunStarRatingUpdateV22(entries: entries)
    }

    func RunStarRatingUpdateV22(entries: [Entry]) -> Void {
        debugPrint("App Version: \(getAppVersion())")
        if getAppVersion() <= 22 && hasRunV22Update == false {
            debugPrint("Current version \(getAppVersion()) is lower than fix 22")
            debugPrint("Running Star Rating Fix")
            UpdateRatingEntries(entries: entries)
            hasRunV22Update = true
            debugPrint("Fix Complete")
        }
        if getAppVersion() <= 22 && hasRunV22Update == true {
            debugPrint("Current version \(getAppVersion()) is lower than fix 22")
            debugPrint("Star Rating Fix Already Applied")
            debugPrint("Abort Fix")
        } else {
            debugPrint("Current version \(getAppVersion()) is higher than fix 22")
            debugPrint("Abort Star Rating Fix")
        }
    }
    
    func getAppVersion() -> Int {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            let appVersionClean = appVersion.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range:nil)
            if let appVersionNum = Int(appVersionClean) {
                return appVersionNum
            }
        }
        return 0
    }
    
    func UpdateRatingEntries(entries: [Entry]) -> Void {
        for entry in entries {
            debugPrint("Changing Star Rating \(String(describing: entry.id))")
            debugPrint(entry.rating)
            entry.rating += 1
            debugPrint(entry.rating)
            saveChanges()
        }
    }
    
    func saveChanges() {
        PersistenceController.shared.saveContext() { error in
            guard error == nil else {
                print("An error occurred while saving: \(error!)")
                return
            }
        }
    }
}

