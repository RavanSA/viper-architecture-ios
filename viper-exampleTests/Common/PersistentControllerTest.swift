//
//  PersistentControllerTest.swift
//  viper-exampleTests
//
//  Created by Revan SADIGLI on 10.03.2024.
//

import XCTest
import CoreData
@testable import viper_example

class PersistenceControllerTests: XCTestCase {

    var persistenceController: PersistenceController!
    var managedObjectContext: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        persistenceController = PersistenceController(inMemory: true)
        managedObjectContext = persistenceController.container.viewContext
    }

    override func tearDown() {
        persistenceController = nil
        managedObjectContext = nil
        super.tearDown()
    }

    func testDeleteAllProductsEntities() {
        insertTestData()

        persistenceController.deleteAll(data: ProductsEntity.self)

        let fetchRequest: NSFetchRequest<ProductsEntity> = ProductsEntity.fetchRequest()
        let count = try! managedObjectContext.count(for: fetchRequest)

        XCTAssertEqual(count, 0, "All ProductsEntity entities should be deleted")
    }

    func insertTestData() {
        let managedObjectContext = persistenceController.container.viewContext

        let product1 = ProductsEntity(context: managedObjectContext)
        product1.id = 1
        product1.title = "Product 1"
        product1.price = 99.99

        let product2 = ProductsEntity(context: managedObjectContext)
        product2.id = 2
        product2.title = "Product 2"
        product2.price = 49.99

        persistenceController.save()
    }
    
}

