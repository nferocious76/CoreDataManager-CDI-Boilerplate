//
//  CoreDataManager.swift
//  CoreDataManager
//
//  Created by Neil Francis Hipona on 1/17/18.
//  Copyright © 2018 Neil Francis Hipona. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager: NSPersistentContainer {

    static let shared = CoreDataManager(name: "CoreDataManager")

    func initialize () {
        loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                #if DEBUG
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                #endif
            }
        })
    }
    
    // MARK: - Core Data stack
    
    var context: NSManagedObjectContext {
        return viewContext
    }

    // MARK: - Core Data Saving support
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                #if DEBUG
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                #endif
            }
        }
    }

    // MARK: - User Controls
    
    func entityDescription(forName name: String) -> NSEntityDescription? {

        let entity = NSEntityDescription.entity(forEntityName: name, in: context)
        return entity
    }
    
    func entityObject(forName name: String) -> NSManagedObject? {
        
        guard let entity = entityDescription(forName: name) else { return nil }
        let object = NSManagedObject(entity: entity, insertInto: context)
        return object
    }
    
    /**
     * NSFetchRequestResult
     */
    func fetchEntityObject(forName name: String, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int = 0) -> (success: Bool, result: [Any]) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = fetchLimit
        
        guard let result = executeFetchRequest(request) else { return (false, []) }
        return (true, result)
    }
    
    func executeFetchRequest(_ request: NSFetchRequest<NSFetchRequestResult>) -> [Any]? {
        
        do {
            let result = try context.fetch(request)
            return result
        }catch{
            return nil
        }
    }
}
