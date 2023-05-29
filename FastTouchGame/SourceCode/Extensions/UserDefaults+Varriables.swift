//
//  UserDefaults+Varriables.swift
//  FastTouchGame
//
//  Created by Dmytro Kmytiuk on 29.05.2023.
//

import Foundation

// MARK: - UserDefault+Variables
extension UserDefaults {
    
        // MARK: - AuthState
    var firstGameState: FirstGameState? {
        get {
            try? get(
                objectType: FirstGameState.self,
                forKey: Constants.UserDefaults.isFirstGame
            )
        }
        set {
            guard let status = newValue else { return }
            try? set(object: status, forKey: Constants.UserDefaults.isFirstGame)
        }
    }
}

enum FirstGameState: Codable {
    case firstGame
    case notFirstGame
    
    static func getFirstGameState() -> FirstGameState? {
        return UserDefaults.standard.firstGameState
    }
    
    static func updateState(to state: FirstGameState) {
        UserDefaults.standard.firstGameState = state
    }
}

