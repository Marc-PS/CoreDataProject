//
//  NoteMO.swift
//  CoreDataProject
//
//  Created by Marc Perelló Sapiña on 20/8/21.
//

import Foundation
import CoreData

@objc(NoteMO)
public class NoteMO: NSManagedObject {
    
    @discardableResult
    static func createNote(notebook: NotebookMO, title: String, createdAt: Date, content: String?, managedObjectContext: NSManagedObjectContext) -> NoteMO? {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: managedObjectContext) as? NoteMO
        
        note?.title = title
        note?.createdAt = createdAt
        note?.content = content
        note?.notebook = notebook
        return note
    }
}
