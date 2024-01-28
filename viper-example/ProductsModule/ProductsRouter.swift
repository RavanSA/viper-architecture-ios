//
//  ProductsRouter.swift
//  viper-example
//
//  Created by Revan Sadigli on 27.10.2023.
//

import Foundation
import UIKit

class ProductsRouter : ProductsRouterProtocol {
    
    weak var view: UIViewController?
    
    static func createModule(vc: ProductsViewController) {
        let interactor = ProductsInteractor()
        let presenter = ProductsPresenter()
        let router = ProductsRouter()

        vc.presenter = presenter
        interactor.presenter = presenter
        router.view = vc
        presenter.view = vc
        presenter.router = router
        presenter.interactor = interactor

    }
    
    func routeToProductDetail() {
        let productDetailVC = ProductDetailViewController(nibName: "ProductDetailViewController", bundle: nil)
        view?.navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    func routeToBasket() {
        let basketVC = BasketViewController(nibName: "BasketViewController", bundle: nil)
        view?.present(basketVC, animated: true, completion: nil)
    }
    
}
    

