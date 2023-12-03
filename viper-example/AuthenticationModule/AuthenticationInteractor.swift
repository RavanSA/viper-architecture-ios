//
//  AuthenticationInteractor.swift
//  viper-example
//
//  Created by Revan Sadigli on 3.09.2023.
//

import Foundation
import FirebaseAuth

class AuthenticationInteractor: AuthenticationInteractorProtocol {

    weak var presenter: AuthenticationPresenterProtocol?

    func didFetchUser(username: String, password: String) {
        DispatchQueue.main.async {
            FirebaseAuth.Auth.auth().signIn(withEmail: username,
                                            password: password) { [weak self] _, error in
                guard let self = self else { return }
                if error != nil {
                    self.presenter?.signInNotSuccess()
                } else {
                    self.presenter?.signInSuccess()
                }
            }
        }
    }

    func didCreateUser(username: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: username, password: password) { [weak self] _, error in
            guard let self = self else { return }
            guard error != nil else {
                self.presenter?.userCreateNotSuccess()
                return
            }
            self.showCreateAccount(username: username, password: password)
        }
    }

    func showCreateAccount(username: String, password: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: username, password: password) { [weak self] _, error in
            guard let self = self else { return }
            guard error == nil else {
                self.presenter?.userCreateNotSuccess()
                return
            }
            self.presenter?.userCreateSuccess()
        }
    }

}
