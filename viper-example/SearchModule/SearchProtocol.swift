//
//  SearchProtocol.swift
//  viper-example
//
//  Created by Revan SADIGLI on 24.02.2024.
//

import Foundation

protocol SearchInteractorProtocol {
    func getAllProducts() -> CoreDataObservable<ProductsEntity>?
    func didFetchCategories()
}

protocol SearchPresenterProtocol: AnyObject {
    func getAllProducts() -> CoreDataObservable<ProductsEntity>?
    func onFetchCategoriesSucces(response: [String])
    func fetchCategories()
    func onFetchCategoriesFailed()
}

protocol SearchViewControllerProtocol: AnyObject {
    func fetchedCategoriesSuccesfully(response: [String])
    func fetchedCategoriesFailed()
}

protocol SearchRouterProtocol {
    func routeToProductDetail(productID id: Int)
}
