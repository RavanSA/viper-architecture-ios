//
//  ProductsEntity.swift
//  viper-example
//
//  Created by Revan Sadigli on 27.10.2023.
//

import Foundation
import CoreData

// MARK: UI Model
struct Categories {
    let categoryName: String
    let categoryImage: String
}

let categories: [Categories] = [
    Categories(categoryName: "PC", categoryImage: "cat1"),
    Categories(categoryName: "Phone", categoryImage: "cat2"),
    Categories(categoryName: "Earphone", categoryImage: "cat3"),
    Categories(categoryName: "Gaming", categoryImage: "cat4"),
    Categories(categoryName: "All", categoryImage: "cat5")
]


// MARK: DTO
struct ProductsDTORequest : Encodable {
    
}

struct ProductsDTOElement: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}

typealias ProductsDTO = [ProductsDTOElement]


//// MARK: CoreData Entity
//@objc(Products)
//public class ProductsManagedObject: NSManagedObject {
//
//}

//extension ProductsManagedObject {
//
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductsManagedObject> {
//        return NSFetchRequest<ProductsManagedObject>(entityName: "Products")
//    }
//
//    @NSManaged public var category: String?
//    @NSManaged public var id: Int64
//    @NSManaged public var image: String?
//    @NSManaged public var price: Double
//    @NSManaged public var productDescription: String?
//    @NSManaged public var rate: String?
//    @NSManaged public var rateCount: Int64
//    @NSManaged public var title: String?
//
//}
