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
}
