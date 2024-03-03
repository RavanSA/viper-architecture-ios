//
//  ErrorManager.swift
//  viper-example
//
//  Created by Revan Sadigli on 23.09.2023.
//

import UIKit

func showMessage(_ message: String, title: String?, view: UIViewController) {
    DispatchQueue.main.async { () -> Void in

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
       
        alert.addAction(ok)
        
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        
            view.present(alert, animated: true)
    }
}
