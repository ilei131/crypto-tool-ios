//
//  ManagedObjectContext.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import CoreData

extension NSManagedObjectContext {
    
    func newChildContext(type: NSManagedObjectContextConcurrencyType = .mainQueueConcurrencyType, mergesChangesFromParent: Bool = true) -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: type)
        context.parent = self
        context.automaticallyMergesChangesFromParent = mergesChangesFromParent
        return context
    }
    
    func quickSave() {
        guard hasChanges else {
            return
        }
        do {
            try save()
        } catch {
            fatalError("failed to save context with error: \(error)")
        }
    }
}
