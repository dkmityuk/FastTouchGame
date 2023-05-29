    //
    //  UILabel+Animations.swift
    //  FastTouchGame
    //
    //  Created by Dmytro Kmytiuk on 28.05.2023.
    //

import UIKit

    // MARK: - Animations
extension UILabel {
    func startPulsatingAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 0.5
        animation.fromValue = 1.0
        animation.toValue = 1.2
        animation.autoreverses = true
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "pulsatingAnimation")
    }
    
    func stopPulsatingAnimation() {
        layer.removeAnimation(forKey: "pulsatingAnimation")
    }
}
