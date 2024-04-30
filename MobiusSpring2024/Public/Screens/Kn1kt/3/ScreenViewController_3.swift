//
//  ScreenViewController_3.swift
//  MobiusSpring2024
//

import UIKit

final class ScreenViewController_3: BaseScreenViewController {
    private let backgroundLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapMeButton.center.y = 200
        setupBackground()
        
        registerForTraitChanges([UITraitUserInterfaceStyle.self], action: #selector(setupBackground))
    }
    
    @objc
    private func setupBackground() {
        backgroundLayer.frame = view.bounds
        backgroundLayer.backgroundColor = UIColor.systemBackground.cgColor
        
//        view.layer.addSublayer(backgroundLayer)
    }
}
