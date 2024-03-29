//
//  Basket+CoreDataProperties.swift
//
//
//  Created by Revan SADIGLI on 3.02.2024.
//
//

import Foundation
import CoreData
import UIKit


extension Basket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Basket> {
        return NSFetchRequest<Basket>(entityName: "Basket")
    }
    
    @nonobjc public class func fetchRequest(forID id: Int) -> NSFetchRequest<Basket> {
        let fetchRequest: NSFetchRequest<Basket> = Basket.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "productID == %d", id)
        return fetchRequest
    }

    @discardableResult
    class func updateColumn(forID id: Int, columnName: String, newValue: Any, context: NSManagedObjectContext) -> Bool {
        let fetchRequest = Basket.fetchRequest(forID: id)
        
        do {
            let baskets = try context.fetch(fetchRequest)
            if let basket = baskets.first {
                basket.setValue(newValue, forKey: columnName)
                try context.save()
                return true
            }
        } catch {
            print("Error updating column: \(error.localizedDescription)")
        }
        
        return false
    }
    
    class func deleteRecordWithProductID(_ value: Int, _ context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Basket> = Basket.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "productID = %@", "\(value)")

        do {
            let result = try context.fetch(fetchRequest)
            guard let entityToDelete = result.first else {
                return
            }
            
            context.delete(entityToDelete)
            try context.save()
        } catch {
            print("Error deleting entity: \(error)")
        }
    }
    
    @NSManaged public var category: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var basketID: Int64
    @NSManaged public var productID: Int64
    @NSManaged public var image: String?
    @NSManaged public var price: String?
    @NSManaged public var ratingCount: String?
    @NSManaged public var ratingRate: String?
    @NSManaged public var productTitle: String?
    @NSManaged public var productQuantity: Int16
    @NSManaged public var userID: Int64

}
