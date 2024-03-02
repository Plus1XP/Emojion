//
//  Persistence.swift
//  Shared
//
//  Created by Plus1XP on 14/04/2022.
//

import CoreData
import CloudKit

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newEntry = Entry(context: viewContext)
            newEntry.id = UUID()
            newEntry.timestamp = Date()
            newEntry.event = "Public Speaking"
            newEntry.emojion = "😬"
            newEntry.feeling = [1,0,0]
            newEntry.rating = 3
            newEntry.note = "Coffee helped anxeity"
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Emojion")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    //Added this!
    func saveContext(completionHandler: @escaping (Error?) -> Void) {
        if PersistenceController.shared.container.viewContext.hasChanges {
            do {
                try PersistenceController.shared.container.viewContext.save()
                completionHandler(nil)
            } catch {
                completionHandler(error)
            }
        }
    }
    
    func RemoveiCloudData(completion: @escaping (_ response: Bool) -> Void) {
        // replace the identifier with your container identifier
        let container = CKContainer(identifier: "iCloud.io.plus1xp.emojion")
        let database = container.privateCloudDatabase
        
        // instruct iCloud to delete the whole zone (and all of its records)
        database.delete(withRecordZoneID: .init(zoneName: "com.apple.coredata.cloudkit.zone"), completionHandler: { (zoneID, error) in
            if let error = error {
                completion(false)
                debugPrint("error deleting zone: - \(error.localizedDescription)")
            } else {
                completion(true)
                debugPrint("successfully deleted zone")
            }
        })
    }
}
