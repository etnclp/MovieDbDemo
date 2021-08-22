//
//  CoreDataManager.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 22.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import CoreData

class CoreDataManager<T: NSManagedObject> {

    private var modelName = "Model"
    private var entityName = String(describing: T.self)

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                log.error("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    public func getItem(_ predicate: NSPredicate? = nil) throws -> [T] {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        return try managedContext.fetch(fetchRequest)
    }

    public func addItem(completion: ((T) -> Void)) throws {
        let managedContext = persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else { return }
        let object = T(entity: entity, insertInto: managedContext)
        completion(object)
        try managedContext.save()
    }

    public func update(item: T) throws {
        let managedContext = persistentContainer.viewContext
        try managedContext.save()
    }

    public func delete(item: T) throws {
        let managedContext = persistentContainer.viewContext
        managedContext.delete(item)
        try managedContext.save()
    }

    public func deleteAll() throws {
        let managedContext = persistentContainer.viewContext
        try self.getItem().forEach { (item) in
            managedContext.delete(item)
        }
        try managedContext.save()
    }

}
