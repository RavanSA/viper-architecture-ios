//
//  AuthenticationPresenter.swift
//  viper-example
//
//  Created by Revan Sadigli on 3.09.2023.
//

import Foundation

class AuthenticationPresenter: AuthenticationPresenterProtocol {

    weak var view: AuthenticationViewControllerProtocol?
    var router: AuthenticationRouterProtocol?
    var interactor: AuthenticationInteractorProtocol?

    func notifyDidButtonTapped(username: String, password: String) {
        interactor?.didFetchUser(username: username, password: password)
    }

    func signInSuccess() {
        view?.updateWithSuccess()
    }

    func signInNotSuccess() {
        view?.updateWithNotSuccess()
    }

    func routeToMain() {
        router?.routeToMain()
    }

    func notifyCreateUserButtonTapped(username: String, password: String) {
        interactor?.didCreateUser(username: username, password: password)
    }

    func userCreateSuccess() {
        view?.userCreated()
    }

    func userCreateNotSuccess() {
        view?.userNotCreated()
    }

}
