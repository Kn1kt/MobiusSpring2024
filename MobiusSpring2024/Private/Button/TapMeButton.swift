//
//  TapMeButton.swift
//  MobiusSpring2024
//

import UIKit

final class TapMeButton: UIButton {    
    convenience init(level: Int) {
        let action = UIAction(title: "Tap Me!") { _ in
            LevelBuilder.shared.currentLevel = level + 1
        }
        
        self.init(type: .system, primaryAction: action)
        
        configuration = .bordered()
    }
}
