//
//  NotebookMO.swift
//  CoreDataProject
//
//  Created by Marc Perelló Sapiña on 6/2/21.
//

import Foundation
import CoreData


public class NotebookMO: NSManagedObject {
    
    @discardableResult
    static func createNotebook(createdAt: Date, title: String, in managedObjectContext: NSManagedObjectContext) -> NotebookMO? {
        
        let notebook = NSEntityDescription.insertNewObject(forEntityName: "Notebook", into: managedObjectContext) as? NotebookMO
        notebook?.title = title
        notebook?.createdAt = createdAt
        
        return notebook
    }
}
