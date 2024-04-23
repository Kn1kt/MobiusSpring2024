//
//  BaseScreenViewController.swift
//  MobiusSpring2024
//

import UIKit
import SwiftUI

class BaseScreenViewController: UIViewController {
    lazy private(set) var tapMeButton: UIButton = {
        let button = TapMeButton(level: level)
        
        button.frame.size = button.intrinsicContentSize
        button.center = .init(x: view.bounds.midX, y: view.bounds.midY)
        
        return button
    }()
    
    init() { super.init(nibName: nil, bundle: nil) }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tapMeButton)
    }
}

class BaseScrenViewController: UIViewController {
    lazy private(set) var tapMeButton: UIButton = {
        let button = TapMeButton(level: level)
        
        button.frame.size = button.intrinsicContentSize
        button.center = .init(x: view.bounds.midX, y: view.bounds.midY)
        
        return button
    }()
    
    init() { super.init(nibName: nil, bundle: nil) }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        // no viewDidLoad here
//        view.addSubview(tapMeButton)
    }
}
