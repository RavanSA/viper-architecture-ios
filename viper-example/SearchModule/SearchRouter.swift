//
//  SearchRouter.swift
//  viper-example
//
//  Created by Revan SADIGLI on 24.02.2024.
//

import UIKit

class SearchRouter : SearchRouterProtocol {
    
    weak var view: UIViewController?
    
    static func createModule(vc: SearchViewController) {
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()

        vc.presenter = presenter
        interactor.presenter = presenter
        router.view = vc
        presenter.view = vc
        presenter.router = router
        presenter.interactor = interactor
    }
    
    func routeToProductDetail(productID id: Int) {
        let productDetailVC = ProductDetailViewController()
        productDetailVC.productID = id
        view?.navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
}
