//
//  BottomBarTemp.swift
//  viper-example
//
//  Created by Revan SADIGLI on 10.12.2023.
//

import UIKit


//MARK: TODO
class SecondViewController: UIViewController {
    let label = createLabel(str: "Settings Page")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        title = "Settings"
        view.addSubview(label)
        label.center = view.center
    }
}

class ThirdViewController: UIViewController {
    
    let label = createLabel(str: "About Page")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        title = "About"
        view.addSubview(label)
        label.center = view.center
    }
}


func createLabel(str : String) -> UILabel {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
    label.text = "\(str)"
    label.font = UIFont(name: label.font.familyName, size: 50)
    label.textAlignment = .center
    label.textColor = .white
    return label
}
