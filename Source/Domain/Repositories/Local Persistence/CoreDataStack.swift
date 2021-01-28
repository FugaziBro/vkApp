//
//  DataStore.swift
//  VkNews
//
//  Created by Pyretttt on 26.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack: PersistentStore{
    
    //MARK: - Properties
    
    public let mainContext: NSManagedObjectContext
    public let privateContext: NSManagedObjectContext
    
    //MARK: - Methods
    
    public init?(){
        // Getting managed object model
        guard let objectModelURL = Bundle.main.url(forResource: "vkNews", withExtension: "momd") else { return nil }
        guard let objectModel = NSManagedObjectModel(contentsOf: objectModelURL) else { return nil }
        
        let persistentCoordinator = NSPersistentStoreCoordinator(managedObjectModel: objectModel)
        
        // Three level contexts hierarchy setup
        let parentContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        parentContext.persistentStoreCoordinator = persistentCoordinator
        
        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.parent = parentContext
        
        privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = mainContext
        
        // Adding persistent store to coordinator
        guard let documentUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else { return nil }
        let appendingStoreURL = documentUrl.appendingPathComponent("vkNews.sqlite")
        do {
            try persistentCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: appendingStoreURL, options: nil)
        } catch {
            print("Could not load persistent store file from disc: \(error.localizedDescription)")
        }
    }
    
    public func saveContextIfNeeded(context: NSManagedObjectContext){
        if context.hasChanges == true {
            saveContext(context: context)
        }
    }
    
    private func saveContext(context: NSManagedObjectContext){
        do {
            try context.save()
            if let parent = context.parent {
                saveContext(context: parent)
            }
        } catch {
            print("Could not save changes to store: \(error.localizedDescription)")
        }
    }
    
}
