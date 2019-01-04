//
//  DataController.swift
//  Flight Info
//
//  Created by Maro on 31/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import Foundation
import CoreData

// Holds a persistent container to load the persistent store, access the context
class DataController {
    let persistentContainer: NSPersistentContainer
    
    // property to access the context (main queue)
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext!
    
    // instantiate the persistent container with the name of the data model file
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func configureContexts() {
        backgroundContext = persistentContainer.newBackgroundContext() // private queue
        
        // merge changes automatically
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
        
        // merge policies. Background context is authority
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
    // the persistent container loads the persistent store
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            self.autoSaveViewContext()
            self.configureContexts()
            completion?()
        }
    }
    
    func autoSaveViewContext(interval:TimeInterval = 30) {
        
        guard interval > 0 else {
            #if DEBUG
            print("Cannot set negative autosave interval")
            #endif
            return
        }
        
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaveViewContext(interval: interval)
        }
    }
}

