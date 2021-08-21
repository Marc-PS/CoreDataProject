//
//  PhotoMO.swift
//  CoreDataProject
//
//  Created by Marc Perelló Sapiña on 20/8/21.
//

import Foundation
import CoreData

@objc(PhotoMO)
public class PhotoMO: NSManagedObject {
    
    static func createPhoto(image: Data, managedObjectContext: NSManagedObjectContext) -> PhotoMO? {
        let photo = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: managedObjectContext) as? PhotoMO
        
        photo?.image = image
        photo?.createdAt = Date()
        return photo
    }
}
