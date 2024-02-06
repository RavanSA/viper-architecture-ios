//
//  Basket+CoreDataProperties.swift
//  
//
//  Created by Revan SADIGLI on 3.02.2024.
//
//

import Foundation
import CoreData


extension Basket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Basket> {
        return NSFetchRequest<Basket>(entityName: "Basket")
    }

    @NSManaged public var category: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var basketID: Int64
    @NSManaged public var productID: Int64
    @NSManaged public var image: String?
    @NSManaged public var price: String?
    @NSManaged public var ratingCount: String?
    @NSManaged public var ratingRate: String?
    @NSManaged public var title: String?
    @NSManaged public var productQuantity: Int16
    @NSManaged public var userID: Int64

}
