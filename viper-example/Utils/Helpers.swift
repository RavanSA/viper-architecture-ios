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

func showActivityIndicator(on parentView: UIView) {
    let  indicatorStyle: UIActivityIndicatorView.Style = .medium
    let  activityIndicator : UIActivityIndicatorView =   UIActivityIndicatorView(style: indicatorStyle)
    
//    let activityIndicator = UIActivityIndicatorView(style: .UIActivityIndicatorView.Style.medium)
    
    activityIndicator.startAnimating()
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false

    parentView.addSubview(activityIndicator)

    NSLayoutConstraint.activate([
        activityIndicator.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
        activityIndicator.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
    ])
}
