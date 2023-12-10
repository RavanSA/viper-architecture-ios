//
//  Extension.swift
//  viper-example
//
//  Created by Revan Sadigli on 23.11.2023.
//

import Foundation
import UIKit

extension UIView {
    
    public func round() {
        let width = bounds.width < bounds.height ? bounds.width : bounds.height
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(ovalIn: CGRectMake(bounds.midX - width / 2, bounds.midY - width / 2, width, width)).cgPath
        self.layer.mask = mask
    }
}

extension Int {
    func toString() -> String {
        return String(self)
    }
}

extension Double {
    func toString() -> String {
        return String(self)
    }
}
