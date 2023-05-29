    //
    //  StartScene.swift
    //  FastTouchGame
    //
    //  Created by Dmytro Kmytiuk on 28.05.2023.
    //

import UIKit
import SpriteKit

final class StartScene: UIViewController {
    
        // MARK: Variables
    private var isAnimationRunning = true
    private var launchInstructor: LaunchInstructor {
        return LaunchInstructor.configure()
    }
    
        // MARK:  UIElements
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var startButton: UIButton!
    private let aimView = UIView()
    
        // MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        switch launchInstructor {
        case .isFirstGame:
            showWelcomeAlert()
            FirstGameState.updateState(to: .notFirstGame)
        case .notFirstGame:
            break
        }
    }
    
    override func viewDidLoad() {
        setupUI()
        startAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isAnimationRunning = false
        titleLabel.stopPulsatingAnimation()
    }
    
        // MARK: - private
    private func setupUI() {
        view.backgroundColor = .white
        wrapperView.backgroundColor = .white
        aimView.backgroundColor = .orange
        titleLabel.startPulsatingAnimation()
        wrapperView.addSubview(aimView)
        startButton.backgroundColor = .orange
        aimView.frame = CGRect(
            x: CGFloat.random(in: .zero...wrapperView.bounds.width),
            y: CGFloat.random(in: .zero...wrapperView.bounds.height),
            width: LocalConstants.targetSize,
            height: LocalConstants.targetSize)
        aimView.makeCircle()
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
    }
    
    private func startAnimation() {
        isAnimationRunning = true
        guard isAnimationRunning else { return }
        
        UIView.animate(
            withDuration: 1.0,
            delay: 1.0,
            options: [.curveLinear],
            animations: { [weak self] in
                self?.aimView.alpha = .zero
            }) { [weak self] _ in
                guard let self = self else { return }
                
                self.aimView.frame.origin = .getRandomCoordinates(parentView: wrapperView, childView: aimView)
                UIView.animate(
                    withDuration: 1.0,
                    delay: 1.0,
                    options: [.curveLinear],
                    animations: { [weak self] in
                        self?.aimView.alpha = 1.0
                    }) { [weak self] _ in
                        self?.startAnimation()
                    }
            }
    }
    
    private func showWelcomeAlert() {
        let alertController = UIAlertController(
            title: LocalConstants.welcomeAlertTitle,
            message: LocalConstants.welcomeAlertMainText,
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func startButtonPressed() {
        
        guard
            let controller = storyboard?.instantiateViewController(
                identifier: LocalConstants.gameSceneId) as? GameScene
        else { return }
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

fileprivate enum LocalConstants {
    
    static let gameSceneId = "GameScene"
    
    static let welcomeAlertTitle = "Game Rules"
    static let welcomeAlertMainText = """
        These are the rules of the game:
        #Tap the target as many times as you can within the given time.
        #Each tap increases your score.
        #Try to achieve the highest score possible.\n\nGood luck!
"""
    
    static let targetSize: CGFloat = 64
}

    // MARK: - LaunchInstructor
private enum LaunchInstructor {
    case isFirstGame
    case notFirstGame
    
    static func configure(firstGameState: FirstGameState? = FirstGameState.getFirstGameState()) -> LaunchInstructor {
        switch firstGameState {
        case .notFirstGame:
            return .notFirstGame
        default:
            return .isFirstGame
        }
    }
}
