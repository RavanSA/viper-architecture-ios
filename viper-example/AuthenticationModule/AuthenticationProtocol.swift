//
//  AuthenticationProtocol.swift
//  viper-example
//
//  Created by Revan Sadigli on 3.09.2023.
//

import Foundation

protocol AuthenticationInteractorProtocol {
    func didFetchUser(username: String, password: String)
    func didCreateUser(username: String, password: String)
}

protocol AuthenticationPresenterProtocol: AnyObject {
    func notifyDidButtonTapped(username: String, password: String)
    func signInSuccess()
    func signInNotSuccess()
    func routeToMain()
    func notifyCreateUserButtonTapped(username: String, password: String)
    func userCreateNotSuccess()
    func userCreateSuccess()
}

protocol AuthenticationViewControllerProtocol: AnyObject {
    func updateWithSuccess()
    func updateWithNotSuccess()
    func userCreated()
    func userNotCreated()
}

protocol AuthenticationRouterProtocol {
    func routeToMain()
}
