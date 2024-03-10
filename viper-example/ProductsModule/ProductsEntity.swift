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
    Categories(categoryName: "PC", categoryImage: "laptopcomputer"),
    Categories(categoryName: "Earphone", categoryImage: "beats.earphones"),
    Categories(categoryName: "Gaming", categoryImage: "gamecontroller"),
    Categories(categoryName: "All", categoryImage: "rectangle.split.2x2.fill")
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

