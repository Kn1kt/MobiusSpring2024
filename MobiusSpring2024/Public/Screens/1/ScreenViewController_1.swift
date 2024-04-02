//
//  ScreenViewController_1.swift
//  MobiusSpring2024
//

import UIKit

final class ScreenViewController_1: BaseScreenViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupBackground()
    }
    
    private func setupBackground() {
        view.backgroundColor = .systemBackground
//        view.isUserInteractionEnabled = false
    }
}
