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
    
    func updateProductQuantity(actionType: BasketActionType, productID: Int, quantity: Int) {
        switch actionType {
        case .increaseProductQuantity:
            increaseProductQuantity(byID: productID, quantity: quantity)
        case .descreaseProductQuantity:
            descreaseProductQuantity(byID: productID, quantity: quantity)
        }
    }
    
    func increaseProductQuantity(byID id: Int, quantity: Int) {
        Basket.updateColumn(forID: id, columnName: "productQuantity", newValue: quantity + 1, context: viewContext)
    }
    
    func descreaseProductQuantity(byID id: Int, quantity: Int) {
        Basket.updateColumn(forID: id, columnName: "productQuantity", newValue: quantity - 1, context: viewContext)
    }
    
    func deleteProductFromBasket(_ productID: Int) {
        Basket.deleteRecordWithProductID(productID, viewContext)
    }

}
