//
//  NSManagedObject.swift
//  Emojion
//
//  Created by Plus1XP on 13/05/2022.
//

import CoreData

extension NSManagedObject {
    func cancelChanges() {
        managedObjectContext?.refresh(self, mergeChanges: false)
    }
}
