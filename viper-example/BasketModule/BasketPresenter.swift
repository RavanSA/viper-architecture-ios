//
//  BasketPresenter.swift
//  viper-example
//
//  Created by Revan SADIGLI on 28.01.2024.
//

import Foundation

class BasketPresenter: BasketPresenterProtocol {
    
    weak var view: BasketViewControllerProtocol?
    var router: BasketRouterProtocol?
    var interactor: BasketInteractorProtocol?
    
    func onAllProductsFromBasket() -> CoreDataObservable<Basket>? {
        return interactor?.getAllProductsFromBasket()
    }
    
    func updateProductQuantity(actionType: BasketActionType, productID: Int, quantity: Int) {
        interactor?.updateProductQuantity(actionType: actionType, productID: productID, quantity: quantity)
    }
    
    func deleteProductFromBasket(_ productID: Int) {
        interactor?.deleteProductFromBasket(productID)
    }
    
    func routeToProductDetail(productID id: Int) {
        router?.routeToProductDetail(productID: id)
    }
    
    func deleteAllProductFromBasket(onComplete: () -> ()) {
        interactor?.deleteAllProductFromBasket(onComplete: onComplete)
    }
    
}
