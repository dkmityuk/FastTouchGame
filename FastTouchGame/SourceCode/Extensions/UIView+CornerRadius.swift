//
//  UIView+CornerRadius.swift
//  FastTouchGame
//
//  Created by Dmytro Kmytiuk on 28.05.2023.
//

import UIKit

    // MARK: - CornerRadius
extension UIView {
    func makeCircle() {
        clipsToBounds = true
        layer.cornerRadius = frame.size.height / 2
    }

}

