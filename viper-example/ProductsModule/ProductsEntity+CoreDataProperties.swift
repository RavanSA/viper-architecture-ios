//
//  ProductsEntity+CoreDataProperties.swift
//  
//
//  Created by Revan SADIGLI on 27.01.2024.
//
//

import Foundation
import CoreData


extension ProductsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductsEntity> {
        return NSFetchRequest<ProductsEntity>(entityName: "Products")
    }

    @NSManaged public var category: String?
    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var price: Double
    @NSManaged public var productDescription: String?
    @NSManaged public var rate: String?
    @NSManaged public var rateCount: Int64
    @NSManaged public var title: String?

}
