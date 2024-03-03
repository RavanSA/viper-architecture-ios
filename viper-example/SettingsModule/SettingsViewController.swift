//
//  SettingsViewController.swift
//  viper-example
//
//  Created by Revan SADIGLI on 3.03.2024.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let stackView = createStackView()
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80)
        ])

    }
    
    func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1)
        
        let versionLabel = createLabel(withText: "v1.0.0 (TEST)", fontSize: 15, color: .lightGray)
        
        let logoutLabel = createLabel(withText: "Logout", fontSize: 24, color: .red)
        stackView.addArrangedSubview(versionLabel)
        stackView.addArrangedSubview(logoutLabel)
        
        return stackView
    }
    
    func createLabel(withText text: String, fontSize: CGFloat, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textAlignment = .center
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

}
