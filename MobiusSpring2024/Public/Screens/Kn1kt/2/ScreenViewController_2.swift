//
//  ScreenViewController_2.swift
//  MobiusSpring2024
//

import UIKit

final class ScreenViewController_2: BaseScreenViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
    }
    
    private func setupBackground() {
        view.backgroundColor = .systemBackground
//        view.layer.opacity = Float.ulpOfOne - Float(view.alpha)
    }
}
