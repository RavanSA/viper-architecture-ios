//
//  ProductsProtocol.swift
//  viper-example
//
//  Created by Revan Sadigli on 27.10.2023.
//

import Foundation

protocol ProductsInteractorProtocol {
    func didFetchProducts()
}

protocol ProductsPresenterProtocol: AnyObject {
    func onFetchProductsSucces(response: ProductsDTO)
    func onFetchProductsFailed()
    func routeToProductDetail()
    func fetchProducts()
}

protocol ProductsViewControllerProtocol: AnyObject {
    func fetchedProductsSuccesfully(response: ProductsDTO)
    func fetchedProductsFailed()
}

protocol ProductsRouterProtocol {
    func routeToProductDetail()
}
