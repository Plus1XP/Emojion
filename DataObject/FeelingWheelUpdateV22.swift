//
//  FeelingWheelUpdateV22.swift
//  Emojion
//
//  Created by nabbit on 23/02/2024.
//

import SwiftUI

struct FeelingWheelUpdateV22 {
    @AppStorage("hasRunFeelingArrayV22Update") var hasRunV22Update: Bool = false
    var entries: [Entry]
    
    init(entries: [Entry]) {
        self.entries = entries
        RunFeelingArrayUpdateV22(entries: entries)
    }

    func RunFeelingArrayUpdateV22(entries: [Entry]) -> Void {
        debugPrint("App Version: \(getAppVersion())")
        if getAppVersion() <= 22 && hasRunV22Update == false {
            debugPrint("Current version \(getAppVersion()) is lower than fix 22")
            debugPrint("Running Feeling Array Fix")
            UpdateFeelingEntries(entries: entries)
            hasRunV22Update = true
            debugPrint("Fix Complete")
        }
        if getAppVersion() <= 22 && hasRunV22Update == true {
            debugPrint("Current version \(getAppVersion()) is lower than fix 22")
            debugPrint("Feeling Array Fix Already Applied")
            debugPrint("Abort Fix")
        } else {
            debugPrint("Current version \(getAppVersion()) is higher than fix 22")
            debugPrint("Abort Feeling Array Fix")
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
    
    func UpdateFeelingEntries(entries: [Entry]) -> Void {
        for entry in entries {
            debugPrint("Changing Array \(String(describing: entry.id))")
            debugPrint(entry.feeling?[0])
            entry.feeling?[0] += 1
            debugPrint(entry.feeling?[0])
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
