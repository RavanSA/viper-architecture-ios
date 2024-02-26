//
//  SearchInteractor.swift
//  viper-example
//
//  Created by Revan SADIGLI on 24.02.2024.
//

import Foundation
import CoreData

class SearchInteractor: SearchInteractorProtocol {
    
    var presenter: SearchPresenterProtocol?
    let viewContext = PersistenceController.shared.viewContext
    let persistentContainer = PersistenceController.shared
    
    func getAllProducts() -> CoreDataObservable<ProductsEntity>? {
        return CoreDataObservable(fetchRequest: ProductsEntity.fetchRequest(),
                                  context: viewContext)
    }
    
    func didFetchCategories() {
        NetworkManager.shared.fetch("products/categories", parameter: CategoriesRequest(), httpMethos: "GET", onSuccess: { (response: [String]) in
            var categories = response
            categories.insert("All", at: 0)
            self.presenter?.onFetchCategoriesSucces(response: categories)
        }, onFailed: { errorMsg in
            self.presenter?.onFetchCategoriesFailed()
        })
    }
    
}
