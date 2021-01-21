//
//  PersistentService.swift
//  PSAWeatherSDK
//
//  Created by Mohamed Lamine Belfekih on 16/01/2021.
//

import Foundation
import CoreData

class PersistenceService {
    
    // MARK: - Core Data stack
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let modelURL = Bundle(for: PSAWeatherSDK.self).url(forResource: "PSAWeatherSDK", withExtension: "momd")
        
        var container: NSPersistentContainer
        
        guard let model = modelURL.flatMap(NSManagedObjectModel.init) else {
            print("Fail to load the trigger model!")
            fatalError()
        }
        
        container = NSPersistentContainer(name: "PSAWeatherSDK", managedObjectModel: model)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
