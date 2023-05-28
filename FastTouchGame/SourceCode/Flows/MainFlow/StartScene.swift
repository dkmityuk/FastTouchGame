//
//  StartScene.swift
//  FastTouchGame
//
//  Created by Dmytro Kmytiuk on 28.05.2023.
//

import UIKit
import SpriteKit

final class StartScene: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    private let animationView = SKView()
    
    override func viewDidLoad() {
        view.backgroundColor = .green
        
        view.addSubview(animationView)
        let scene = makeScene()
        animationView.frame.size = scene.size
        animationView.presentScene(scene)
        animationView.backgroundColor = .clear
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        animationView.center.x = view.bounds.midX
        animationView.center.y = view.bounds.midY
    }

    
    private func makeScene() -> SKScene {
        let dimension = min(view.frame.width, view.frame.height)
        let size = CGSize(width: dimension, height: dimension)
        let scene = SKScene(size: size)
        scene.backgroundColor = .white
        
        self.addNodes(to: scene)
        self.animateNode(scene.children.first!)
        
        return scene
    }
    
    private func addNodes(to scene: SKScene) {
        
        let target = "🎯"
        let node = SKLabelNode()
        node.render(target)
        scene.addChild(node)
    }
    
    private func animateNode(_ node: SKNode) {
        let fadeIn = SKAction.fadeIn(withDuration: 1.0)
        let fadeOut = SKAction.fadeOut(withDuration: 1.0)

        let randomX = CGFloat.random(in: 0...(node.scene?.size.width)! )
        let randomY = CGFloat.random(in: 0...(node.scene?.size.height)! )
        let moveAction = SKAction.move(to: CGPoint(x: randomX, y: randomY), duration: 0.0)

        let sequence = SKAction.sequence([
            fadeIn,
            SKAction.wait(forDuration: 1.0),
            fadeOut,
            moveAction
        ])

        node.run(SKAction.repeatForever(sequence))
    }
    
    
    
    
}

extension SKLabelNode {
    
    func render(_ string: String) {
        fontSize = 50
        text = string
        fontColor = .black
        
        verticalAlignmentMode = .center
        horizontalAlignmentMode = .center
    }
    
}


