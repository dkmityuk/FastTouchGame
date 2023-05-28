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
    
    override func viewDidLoad() {
        view.backgroundColor = .green
        
        setupUI()
        
    }
    
    private func setupUI() {
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
    }
    
    @objc private func startButtonPressed() {
        print(24)
        
        guard
            let controller = storyboard?.instantiateViewController(
                identifier: LocalConstants.gameSceneId) as? GameScene
        else { return }
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

fileprivate enum LocalConstants {
    
    static let gameSceneId = "GameScene"
    
}
