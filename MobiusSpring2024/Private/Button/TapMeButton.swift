//
//  TapMeButton.swift
//  MobiusSpring2024
//

import UIKit

final class TapMeButton: UIButton {    
    convenience init(action: @escaping () -> Void) {
        let primaryAction = UIAction(title: "Продолжить") { _ in
            action()
        }
        self.init(type: .system, primaryAction: primaryAction)
        configuration = .bordered()
    }
}
