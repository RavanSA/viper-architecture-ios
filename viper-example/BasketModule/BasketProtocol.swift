//
//  BasketProtocol.swift
//  viper-example
//
//  Created by Revan SADIGLI on 28.01.2024.
//

import Foundation

protocol BasketInteractorProtocol {
    func getAllProductsFromBasket() -> CoreDataObservable<Basket>?
    func updateProductQuantity(actionType: BasketActionType, productID: Int, quantity: Int)
    func deleteProductFromBasket(_ productID: Int)
    func deleteAllProductFromBasket(onComplete: () -> ())
}

protocol BasketPresenterProtocol: AnyObject {
    func onAllProductsFromBasket() -> CoreDataObservable<Basket>?
    func updateProductQuantity(actionType: BasketActionType, productID: Int, quantity: Int)
    func deleteProductFromBasket(_ productID: Int)
    func deleteAllProductFromBasket(onComplete: () -> ())
    func routeToProductDetail(productID id: Int)
}

protocol BasketViewControllerProtocol: AnyObject {

}

protocol BasketRouterProtocol {
    func routeToProductDetail(productID id: Int)
}
