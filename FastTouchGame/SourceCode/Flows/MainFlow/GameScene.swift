//
//  ViewController.swift
//  FastTouchGame
//
//  Created by Dmytro Kmytiuk on 27.05.2023.
//

import UIKit

final class GameScene: UIViewController {
    
    var tapCount: Int = 0
    
    // MARK:  UIElements
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    private var target = UIView()
    private var timeRemaining = 7
    private var timer = Timer()
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startTimer()
    }
    
    // MARK: Private
    private func setupUI() {
        let dimension = min(view.frame.width, view.frame.height)
        let size = CGSize(width: dimension, height: dimension)
        animationView.frame.size = size
        animationView.backgroundColor = .white
        target = UIView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        target.center = CGPoint(x: size.width / 2, y: size.height / 2)
        target.backgroundColor = .blue
        animationView.addSubview(target)
        timerLabel.textColor = .black
        timerLabel.font = .systemFont(ofSize: 18)
        target.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTargetTap)))
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
        
        if timeRemaining <= 0 {
            timer.invalidate()
            endGame()
        }
    }
    
    @objc private func handleTargetTap() {
        target.removeFromSuperview()
        tapCount += 1
        
        let randomX = CGFloat.random(in: (target.bounds.width )/2...(animationView.bounds.width - (target.bounds.width )/2))
        let randomY = CGFloat.random(in: (target.bounds.height )/2...(animationView.bounds.height - (target.bounds.height )/2))
        target.center = CGPoint(x: randomX, y: randomY)
        
        animationView.addSubview(target)
    }
    
    private func endGame() {
        
        guard
            let controller = storyboard?.instantiateViewController(
                identifier: LocalConstants.endGameControllerId) as? EndGameScene
        else { return }

        if tapCount >= 10 {
            print("YOU WIN")
            controller.urlString = LocalConstants.googleURL
        } else {
            print("nowbody believe in you")
            controller.urlString = LocalConstants.youtubeURL
        }

        navigationController?.pushViewController(controller, animated: true)

    }
    
}

fileprivate enum LocalConstants {
    static let endGameControllerId = "EndGameScene"
    
    static let googleURL = "https://www.google.com"
    static let youtubeURL = "https://www.youtube.com"
}
