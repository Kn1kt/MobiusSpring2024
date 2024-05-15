//
//  ScreenViewController_9.swift
//  MobiusSpring2024
//
//  Created by Vladislav Diakov on 15.05.2024.
//

import UIKit

final class ScreenViewController_9: BaseScreenViewController {
    private let rightPattern = [1, 4, 7, 8, 9, 6, 3]
    
    private var isLevelCompleted = false {
        didSet {
            self.tapMeButton.isEnabled = self.isLevelCompleted
        }
    }

    private let levelTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.text = "Введи правильный пароль"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubviews()
        
    }

    private func setupSubviews() {
        let patternView = PatternView(frame: self.view.frame)
        patternView.backgroundColor = .white
        patternView.delegate = self
        self.view.addSubview(patternView)

        self.view.addSubview(self.levelTitle)
        self.levelTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.levelTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.levelTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.levelTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.levelTitle.heightAnchor.constraint(equalToConstant: 60)
        ])

        self.tapMeButton.isEnabled = false
        self.tapMeButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tapMeButton)

        NSLayoutConstraint.activate([
            self.tapMeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.tapMeButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ScreenViewController_9: PatternViewDelegate {
    func patternCompleted(pattern: [Int]) {
        self.isLevelCompleted = pattern == self.rightPattern
    }
}
