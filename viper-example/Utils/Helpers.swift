//
//  Helpers.swift
//  viper-example
//
//  Created by Revan SADIGLI on 24.02.2024.
//

import UIKit


func changeSafeAreaBackgroundColor(to color: UIColor, for view: UIView) {
    let bottomView = UIView()
    bottomView.backgroundColor = UIColor.red
    bottomView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(bottomView)
    
    NSLayoutConstraint.activate([
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        bottomView.heightAnchor.constraint(equalToConstant: 34)
    ])
}
