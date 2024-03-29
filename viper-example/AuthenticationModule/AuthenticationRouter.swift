//
//  AuthenticationRouter.swift
//  viper-example
//
//  Created by Revan Sadigli on 3.09.2023.
//

import UIKit

class AuthenticationRouter: AuthenticationRouterProtocol {

    var view: UIViewController?

    static func createModule(vc: AuthenticationViewController) {
        let interactor = AuthenticationInteractor()
        let presenter = AuthenticationPresenter()
        let router = AuthenticationRouter()

        vc.presenter = presenter
        interactor.presenter = presenter
        router.view = vc
        presenter.view = vc
        presenter.router = router
        presenter.interactor = interactor
    }

    func routeToMain() {
        setupBottomBar()
    }
    
    func setupBottomBar() {
        let tabBarVC = UITabBarController()
        let vc1 = UINavigationController(rootViewController: ProductsViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let vc3 = storyboard.instantiateViewController(withIdentifier: "settingsVC")
        
        vc1.title = "Home"
        vc2.title = "Search"
        vc3.title = "Settings"


        tabBarVC.setViewControllers([vc1, vc2, vc3], animated: false)

        let items = tabBarVC.tabBar.items

        let images = ["house","magnifyingglass","gear"]

        for item in 0..<items!.count {
            items![item].image = UIImage(systemName: images[item])
        }

        tabBarVC.modalPresentationStyle = .fullScreen
        view?.present(tabBarVC,animated: true)
    }
    
}
