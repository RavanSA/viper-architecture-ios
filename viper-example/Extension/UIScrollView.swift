//
//  UIScrollView.swift
//  viper-example
//
//  Created by Revan Sadigli on 2.09.2023.
//

import Foundation
import UIKit

enum ScrollDirection {
    case up, left, down, right, none
}

protocol ScrollDirectionDetectable {
    associatedtype ScrollViewType: UIScrollView
    var scrollView: ScrollViewType { get }
    var scrollDirection: ScrollDirection { get set }
    var lastContentOffset: CGPoint { get set }
}

extension ScrollDirectionDetectable {
    var scrollView: ScrollViewType {
        return self.scrollView
    }
}
