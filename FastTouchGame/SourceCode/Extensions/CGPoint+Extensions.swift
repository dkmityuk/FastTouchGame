//
//  CGPoint+Extensions.swift
//  FastTouchGame
//
//  Created by Dmytro Kmytiuk on 29.05.2023.
//

import UIKit

extension CGPoint {
    static func getRandomCoordinates(parentView: UIView, childView: UIView) -> CGPoint {
        
        let maxX = parentView.bounds.width - childView.bounds.width
        let maxY = parentView.bounds.height - childView.bounds.height
        
        let randomX = CGFloat.random(in: .zero...maxX)
        let randomY = CGFloat.random(in: .zero...maxY)
        
        let targetOriginX = max(.zero, min(randomX, maxX - childView.bounds.width))
        let targetOriginY = max(.zero, min(randomY, maxY - childView.bounds.height))
        
        return CGPoint(x: targetOriginX, y: targetOriginY)
    }
    
}
