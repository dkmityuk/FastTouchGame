//
//  EndGameScene.swift
//  FastTouchGame
//
//  Created by Dmytro Kmytiuk on 28.05.2023.
//

import UIKit
import WebKit

class EndGameScene: UIViewController {

    var urlString: String?
    
    @IBOutlet weak var resultWebView: WKWebView!
     
    override func viewDidLoad() {
        super.viewDidLoad()

        if let urlString = urlString, let url = URL(string: urlString) {
            
            resultWebView.load(URLRequest(url: url))
            view.addSubview(resultWebView)
        }
  

    }
    

}
