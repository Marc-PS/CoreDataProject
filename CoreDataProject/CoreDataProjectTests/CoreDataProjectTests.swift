//
//  CoreDataProjectTests.swift
//  CoreDataProjectTests
//
//  Created by Marc Perelló Sapiña on 6/2/21.
//

import XCTest
import CoreData
@testable import CoreDataProject

class CoreDataProjectTests: XCTestCase {

    private let modelName = "NotebooksModel"
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInit_DataController_Initializes() {
        DataController(modelName: modelName) { _ in
            XCTAssert(true)
        }
    }
    
    func testInit_Notebook () {
        DataController(modelName: modelName) { (persistentContainer) in
            guard let persistentContainer = persistentContainer else {
                XCTFail()
                return
            }
            let managedObjectContext = persistentContainer.viewContext
            
            let notebook1 = NotebookMO.createNotebook(createdAt: Date(),
                                                      title: "notebook1",
                                                      in: managedObjectContext)
            XCTAssertNotNil(notebook1)
        }
    }
    
    func testFetch_DataController_FetchesANotebook() {
        let dataController = DataController(modelName: modelName) { (persistentContainer) in
            guard persistentContainer != nil else {
                XCTFail()
                return
            }
        }
        
        dataController.loadNotebooksIntoViewContext()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notebook")
        
        let notebooks = dataController.fetchNotebooks(using: fetchRequest)
        
        XCTAssertEqual(notebooks?.count, 3)
    }
    
    func testFilter_DataController_FilterNotebooks() {
        let dataController = DataController(modelName: modelName) { (persistentContainer) in
            guard persistentContainer != nil else {
                XCTFail()
                return
            }
            
        }
        
        dataController.loadNotebooksIntoViewContext()
       
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notebook")
        
        fetchRequest.predicate = NSPredicate(format: "title == %@", "notebook1")
        
        let notebooks = dataController.fetchNotebooks(using: fetchRequest)
        
        XCTAssertEqual(notebooks?.count, 1)
            
    }
    
    func testSave_DataController_SavesInPersistentStore() {
        
        let dataController = DataController(modelName: modelName) { (persistentContainer) in
            guard persistentContainer != nil else {
                XCTFail()
                return
            }
            
        }
       
        dataController.loadNotebooksIntoViewContext()
        dataController.save()
        dataController.reset()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notebook")
        let notebooks = dataController.fetchNotebooks(using: fetchRequest)
        
        XCTAssertEqual(notebooks?.count, 3)
        
    }
    
    func insertNotebooksInto(managedObjectContext: NSManagedObjectContext) {
       
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
