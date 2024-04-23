//
//  BashScreenViewController_5.swift
//  MobiusSpring2024
//
//  Created by Bashir Arslanaliev on 06.04.2024.
//

import UIKit

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
