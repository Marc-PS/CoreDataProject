//
//  DataController.swift
//  CoreDataProject
//
//  Created by Marc Perelló Sapiña on 5/2/21.
//

import Foundation
import CoreData

class DataController: NSObject {
    let persistentContainer: NSPersistentContainer
    
    @discardableResult
    init(modelName: String, completionHandler: (@escaping (NSPersistentContainer?) -> ())) {
        self.persistentContainer = NSPersistentContainer(name: modelName)
        super.init()
        
        persistentContainer.loadPersistentStores { [weak self] (description, error) in
            if let error = error {
                fatalError("Couldn't load CoreData Stack \(error.localizedDescription)")
            }
            
            completionHandler(self?.persistentContainer)
        }
    }
    
    func fetchNotebooks(using fetchRequest: NSFetchRequest<NSFetchRequestResult>) -> [NotebookMO]? {
       
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest) as? [NotebookMO]
        } catch {
            fatalError("Failure to fetch notebooks with context: \(fetchRequest), \(error)")
        }
    }
    
    func save() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("=== could not save view context ===")
            print("error: \(error.localizedDescription)")
        }
    }
    
    func reset() {
        persistentContainer.viewContext.reset()
    }
}


extension DataController {
    
    func loadNotebooksIntoViewContext() {
        
        let managedObjectContext = persistentContainer.viewContext
        
        NotebookMO.createNotebook(createdAt: Date(),
                                                  title: "notebook1",
                                                  in: managedObjectContext)
        
        NotebookMO.createNotebook(createdAt: Date(),
                                                  title: "notebook2",
                                                  in: managedObjectContext)
        
        NotebookMO.createNotebook(createdAt: Date(),
                                                  title: "notebook3",
                                                  in: managedObjectContext)
    }
}
