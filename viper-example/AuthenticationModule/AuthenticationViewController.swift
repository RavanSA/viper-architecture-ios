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
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: Properties
    var presenter: AuthenticationPresenterProtocol?
    var activityIndicatorView: UIActivityIndicatorView?
    private var fromSegment: Bool = false


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
        signInEmail.text = "test123@gmail.com.com"
        signInPassword.text = "123456"
        registerBtn.addTarget(self, action: #selector(createUser), for: .touchUpInside)
        signIn.addTarget(self, action: #selector(signInToTheApp), for: .touchUpInside)
        activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView!.center = CGPoint(x: view.frame.size.width  / 2, y: 0)
        view.addSubview(activityIndicatorView!)
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
    
    
    @IBAction func onSegmentChange(_ sender: UISegmentedControl) {
        fromSegment = true
        segmentChanged(index: sender.selectedSegmentIndex)
    }
    
    func segmentChanged(index: Int) {
        if index == 0 {
            self.scrollView.setContentOffset(CGPoint.zero, animated: true)
        } else {
            self.scrollView.setContentOffset(CGPoint(x: self.signIn.frame.maxX + 20, y: 0), animated: true)
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

extension AuthenticationViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView && !fromSegment {
            let offsetX = scrollView.contentOffset.x
            let frameW = scrollView.frame.size.width
            
            if roundf( Float(offsetX / frameW) ) < 1 {
                segmentControl.selectedSegmentIndex = 0
            } else {
                segmentControl.selectedSegmentIndex = 1
            }
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        fromSegment = false
    }
}
