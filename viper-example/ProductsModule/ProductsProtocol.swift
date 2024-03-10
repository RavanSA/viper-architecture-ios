//
//  ProductsProtocol.swift
//  viper-example
//
//  Created by Revan Sadigli on 27.10.2023.
//

import Foundation

protocol ProductsInteractorProtocol {
    func didFetchProducts(request: ProductsDTORequest)
}

protocol ProductsPresenterProtocol: AnyObject {
    @discardableResult func onFetchProductsSucces(response: ProductsDTO) -> Bool
    @discardableResult func onFetchProductsFailed() -> Bool
    func routeToProductDetail()
    func fetchProducts()
    func routeToBasket()
}

protocol ProductsViewControllerProtocol: AnyObject {
    func fetchedProductsSuccesfully(response: ProductsDTO)
    func fetchedProductsFailed()
}

protocol ProductsRouterProtocol {
    func routeToProductDetail()
    func routeToBasket()
}
