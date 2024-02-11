//
//  BasketInteractor.swift
//  viper-example
//
//  Created by Revan SADIGLI on 28.01.2024.
//

import Foundation


class BasketInteractor : BasketInteractorProtocol {

    var presenter: BasketPresenterProtocol?
    let viewContext = PersistenceController.shared.viewContext
    let persistentContainer = PersistenceController.shared
    
    func getAllProductsFromBasket() -> CoreDataObservable<Basket>? {
        return CoreDataObservable(fetchRequest: Basket.fetchRequest(),
                                  context: viewContext)
    }
    
}
