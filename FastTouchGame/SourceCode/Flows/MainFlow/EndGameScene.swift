//
//  EndGameScene.swift
//  FastTouchGame
//
//  Created by Dmytro Kmytiuk on 28.05.2023.
//

import UIKit
import WebKit

class EndGameScene: UIViewController {
    
    // MARK: - Variables
    var urlString: String?
    
    // MARK: - UIElements
    @IBOutlet weak var resultWebView: WKWebView!
    private let backButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupWebView()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        view.backgroundColor = .white
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func setupWebView() {
        if let urlString = urlString, let url = URL(string: urlString) {
            resultWebView.load(URLRequest(url: url))
            view.addSubview(resultWebView)
        }
        resultWebView.backgroundColor = .white
    }
    
    @objc private func backButtonPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
