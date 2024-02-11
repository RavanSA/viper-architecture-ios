//
//  ProductDetailInteractor.swift
//  viper-example
//
//  Created by Revan SADIGLI on 9.12.2023.
//

import Foundation
import CoreData

class ProductDetailInteractor : ProductDetailInteractorProtocol {

    var presenter: ProductDetailPresenterProtocol?
    let viewContext = PersistenceController.shared.viewContext
    let persistentContainer = PersistenceController.shared
    
    func didFetchProductDetail(productID id : Int?) {
        NetworkManager.shared.fetch("products/\(id ?? 0)", parameter: ProductDetailDTORequest(), httpMethos: "GET", onSuccess: { (response: ProductDetailResponse) in
            self.presenter?.onFetchProductDetailSucces(response: response)
        }, onFailed: { errorMsg in
            self.presenter?.onFetchProductDetailFailed(errorMsg: errorMsg)
        })
    }
    
    func insertProductToBasket(product productDetail: ProductDetailResponse?) {
        if let productDetail {
            persistentContainer.container.performBackgroundTask {context in
                do {
                    let basketEntity = Basket(context: context)
                    
                    basketEntity.productID = Int64(productDetail.id)
                    basketEntity.basketID = Int64(productDetail.id)
                    basketEntity.category = productDetail.category
                    basketEntity.image = productDetail.image
                    basketEntity.productDescription = productDetail.description
                    basketEntity.price = productDetail.price.toString()
                    basketEntity.ratingRate = productDetail.rating.rate.toString()
                    basketEntity.ratingCount = productDetail.rating.count.toString()
                    basketEntity.productQuantity = 1
                    
                    try context.save()
                } catch {
                    print("Error Occured", error)
                }
            }
        }
    }
    
    func updateProductQuantity(actionType: BasketActionType, productID: Int, quantity: Int) {
        switch actionType {
        case .increaseProductQuantity:
            increaseProductQuantity(byID: productID, quantity: quantity)
        case .descreaseProductQuantity:
            descreaseProductQuantity(byID: productID, quantity: quantity)
        }
    }
    
    func fetchProduct(byId id: Int) -> CoreDataObservable<Basket>? {
        return CoreDataObservable(fetchRequest: Basket.fetchRequest(forID: id),
                                  context: viewContext)
    }
    
    func increaseProductQuantity(byID id: Int, quantity: Int) {
        Basket.updateColumn(forID: id, columnName: "productQuantity", newValue: quantity + 1, context: viewContext)
    }
    
    func descreaseProductQuantity(byID id: Int, quantity: Int) {
        Basket.updateColumn(forID: id, columnName: "productQuantity", newValue: quantity - 1, context: viewContext)
    }
    
}
