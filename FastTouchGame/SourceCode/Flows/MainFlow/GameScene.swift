//
//  ViewController.swift
//  FastTouchGame
//
//  Created by Dmytro Kmytiuk on 27.05.2023.
//

import UIKit
import SpriteKit

class GameScene: Scene {
    
    private let animationView = SKView()
    private let scene = SKScene()
    private var target: SKSpriteNode!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        
        view.addSubview(animationView)
        animationView.presentScene(scene)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        animationView.center.x = view.bounds.midX
        animationView.center.y = view.bounds.midY
    }
    
    private func setupUI() {
        let dimension = min(view.frame.width, view.frame.height)
        let size = CGSize(width: dimension, height: dimension)

        scene.size = size
        
        scene.backgroundColor = .red
        
        
        animationView.frame.size = scene.size
        
        
            // Создание мишени
        target = SKSpriteNode(imageNamed: "target")
        target.position = CGPoint(x: size.width / 2, y: size.height / 2)
        scene.addChild(target)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: scene)
        let touchedNodes = scene.nodes(at: touchLocation)
        
        if touchedNodes.contains(target) {
                // Remove the current target
            target.removeFromParent()
            
                // Create a new target at a random position
            let randomX = CGFloat.random(in: 0...scene.size.width)
            let randomY = CGFloat.random(in: 0...scene.size.height)
            
            target.position = CGPoint(x: randomX, y: randomY)
            
                // Add the new target to the scene
            scene.addChild(target)
        }
    }



}

// MARK: - LocalConstants
fileprivate enum LocalConstants {
    
    
}
