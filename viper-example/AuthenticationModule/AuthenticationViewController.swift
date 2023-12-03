//
//  AuthenticationViewController.swift
//  viper-example
//
//  Created by Revan Sadigli on 3.09.2023.
//

import UIKit

class AuthenticationViewController: UIViewController, AuthenticationViewControllerProtocol {

    
    // MARK: Outlets
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var signInPassword: UITextField!
    @IBOutlet weak var signInEmail: UITextField!
    @IBOutlet weak var signIn: UIButton!

    
    // MARK: Properties
    public var presenter: AuthenticationPresenterProtocol?
    private var activityIndicatorView: UIActivityIndicatorView?


    // MARK: - View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        AuthenticationRouter.createModule(vc: self)
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.isHidden = false
    }

    private func setupUI() {
        userName.text = ""
        email.text = ""
        confirmPassword.text = ""
        password.text = ""
        signInEmail.text = ""
        signInPassword.text = ""
        registerBtn.addTarget(self, action: #selector(createUser), for: .touchUpInside)
        signIn.addTarget(self, action: #selector(signInToTheApp), for: .touchUpInside)
        activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView!.center = CGPoint(x: view.frame.size.width  / 2, y: 0)
        view.addSubview(activityIndicatorView!)
        presenter?.routeToMain()
    }

    
    // MARK: - Actions
    @objc private func createUser() {
         if email.text != "" && password.text != "" && confirmPassword.text != "" {
             if password.text == confirmPassword.text {
                 guard let email = email.text else { return }
                 guard let password = password.text else { return }
                 activityIndicatorView!.startAnimating()
                 presenter?.notifyCreateUserButtonTapped(username: email, password: password)
             } else {
                 showMessage("Error!", title: "Passwords are not matched!")
             }
         } else {
             showMessage("Error!", title: "You should fill every single field!")
         }
     }

    @objc private func signInToTheApp() {
         if (signInEmail.text != "") && (signInPassword.text != "") {
             guard let username = signInEmail.text else { return }
             guard let password = signInPassword.text else { return }
             presenter?.notifyDidButtonTapped(username: username, password: password)
         } else {
             showMessage("Error!", title: "You should fill every single field!")
         }
     }

}


// MARK: - Functions
extension AuthenticationViewController {
    func userCreated() {
        self.activityIndicatorView!.stopAnimating()
        self.presenter?.routeToMain()
    }
    
    func userNotCreated() {
        let alert = UIAlertController(title: "Error!", message: "Something went wrong! Try again.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            guard let self = self else { return }
            self.userName.text = nil
            self.password.text = nil
            self.userName.becomeFirstResponder()
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func updateWithSuccess() {
        presenter?.routeToMain()
    }
    
    func updateWithNotSuccess() {
        
    }
}
