//
//  ViewController.swift
//  FastTouchGame
//
//  Created by Dmytro Kmytiuk on 27.05.2023.
//

import UIKit

final class GameScene: UIViewController {
    
    // MARK: Variables
    private var tapCount: Int = .zero
    private var timeRemaining = LocalConstants.timeRemaining
    private var gameStarted = false
    
    // MARK:  UIElements
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var aimView = UIView()
    private var timer = Timer()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Private
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        wrapperView.backgroundColor = .white
        aimView.frame = CGRect(
            x: view.bounds.midX - (LocalConstants.aimSize / 2),
            y: view.bounds.midY - (LocalConstants.aimSize * 2),
            width: LocalConstants.aimSize,
            height: LocalConstants.aimSize)
        aimView.backgroundColor = .orange
        aimView.makeCircle()
        wrapperView.addSubview(aimView)
        descriptionLabel.startPulsatingAnimation()
        aimView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTargetTap)))
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true)
    }
    
    @objc private func updateTimer() {
        timeRemaining -= 1
        timerLabel.text = "Time: \(timeRemaining)"
        
        if timeRemaining <= .zero {
            timer.invalidate()
            endGame()
        }
    }
    
    @objc private func handleTargetTap() {
        if !gameStarted {
            descriptionLabel.isHidden = true
            tapCount = .zero
            aimView.removeFromSuperview()
            aimView.frame.origin = .getRandomCoordinates(parentView: wrapperView, childView: aimView)
            gameStarted = true
            startTimer()
            wrapperView.addSubview(aimView)
            return
        }
        UIView.animate(withDuration: 0.15) { [weak self] in
            self?.aimView.alpha = .zero
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.aimView.removeFromSuperview()
            self.tapCount += 1
            self.aimView.frame.origin = .getRandomCoordinates(parentView: wrapperView, childView: aimView)
            self.aimView.alpha = 1.0
            self.wrapperView.addSubview(self.aimView)
        }
        
    }
        
    private func endGame() {
        guard
            let controller = storyboard?.instantiateViewController(
                identifier: LocalConstants.endGameControllerId) as? EndGameScene
        else { return }
        
        if tapCount >= 10 {
            controller.urlString = LocalConstants.googleURL
        } else {
            controller.urlString = LocalConstants.youtubeURL
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

fileprivate enum LocalConstants {
    static let endGameControllerId = "EndGameScene"
    
    static let googleURL = "https://www.google.com"
    static let youtubeURL = "https://www.youtube.com"
    
    static let aimSize: CGFloat = 64
    static let timeRemaining = 7
}
