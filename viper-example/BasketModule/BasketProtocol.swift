//
//  BasketProtocol.swift
//  viper-example
//
//  Created by Revan SADIGLI on 28.01.2024.
//

import Foundation

protocol BasketInteractorProtocol {
    func getAllProductsFromBasket() -> CoreDataObservable<Basket>?
}

protocol BasketPresenterProtocol: AnyObject {
    func onAllProductsFromBasket() -> CoreDataObservable<Basket>?
}

protocol BasketViewControllerProtocol: AnyObject {

}

protocol BasketRouterProtocol {

}
