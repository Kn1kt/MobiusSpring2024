//
//  BashScreenViewController_5.swift
//  MobiusSpring2024
//

import UIKit
import Internals

final class BashScreenViewController_5: BaseScrenViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }
    private func setupButton() {
        tapMeButton.tintColor = .systemPink
        tapMeButton.isUserInteractionEnabled = true
        tapMeButton.center.y = view.frame.maxY - view.frame.height
    }
}
