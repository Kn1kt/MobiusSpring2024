//
//  ScreenViewController_3.swift
//  MobiusSpring2024
//

import UIKit

final class ScreenViewController_3: BaseScreenViewController {
    private let levelTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.text = "Расположи все цифры в порядке возрастания"
        return label
    }()

    private let levelView = UIView()
    private let notchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()

    private var draggableViews: [UIView] = []
    private var notchViews: [UIView] = []

    private var isLevelCompleted = false {
        didSet {
            self.tapMeButton.isEnabled = self.isLevelCompleted
        }
    }

    private enum Constants {
        static let diceCount: Int = 6
        static let diceSize = CGSize(width: 40, height: 60)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground

        self.setupSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.createDraggableViews()
    }

    private func setupSubviews() {
        self.tapMeButton.isEnabled = false

        self.view.addSubview(self.levelTitle)
        self.levelTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.levelTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.levelTitle.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.levelTitle.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.levelTitle.heightAnchor.constraint(equalToConstant: 60)
        ])

        self.view.addSubview(self.levelView)
        self.levelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.levelView.topAnchor.constraint(equalTo: self.levelTitle.bottomAnchor),
            self.levelView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.levelView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])

        self.notchStackView.translatesAutoresizingMaskIntoConstraints = false
        self.levelView.addSubview(self.notchStackView)
        NSLayoutConstraint.activate([
            self.notchStackView.heightAnchor.constraint(equalToConstant: 100),
            self.notchStackView.centerYAnchor.constraint(equalTo: self.levelView.centerYAnchor),
            self.notchStackView.leadingAnchor.constraint(equalTo: self.levelView.leadingAnchor, constant: 40),
            self.notchStackView.trailingAnchor.constraint(equalTo: self.levelView.trailingAnchor, constant: 40)
        ])

        for i in 1 ... Constants.diceCount {
            let notchView = UILabel()
            notchView.layer.cornerRadius = 13
            notchView.layer.masksToBounds = true
            notchView.backgroundColor = .darkGray
            notchView.tag = i
            self.notchViews.append(notchView)

            notchView.translatesAutoresizingMaskIntoConstraints = false
            self.notchStackView.addArrangedSubview(notchView)
            NSLayoutConstraint.activate([
                notchView.heightAnchor.constraint(equalToConstant: Constants.diceSize.height),
                notchView.widthAnchor.constraint(equalToConstant: Constants.diceSize.width)
            ])
        }

        self.tapMeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tapMeButton.topAnchor.constraint(equalTo: self.levelView.bottomAnchor, constant: 20),
            self.tapMeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.tapMeButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func createDraggableViews() {
        self.draggableViews.forEach { $0.removeFromSuperview() }
        self.draggableViews = []

        for i in 1 ... Constants.diceCount {
            let diceView = UILabel()
            diceView.layer.cornerRadius = 12
            diceView.layer.masksToBounds = true
            diceView.layer.borderWidth = 2
            diceView.layer.borderColor = UIColor.gray.cgColor
            diceView.backgroundColor = .lightGray
            diceView.font = .systemFont(ofSize: 24, weight: .semibold)
            diceView.textAlignment = .center
            diceView.text = "\(i)"
            diceView.tag = i

            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onDrag))
            diceView.addGestureRecognizer(panGesture)

            let randomOrigin = self.getRandomPointInRectExcludingArea(
                rect: self.levelView.bounds.inset(by: .init(top: 0, left: 0, bottom: Constants.diceSize.height, right: Constants.diceSize.width)),
                excludedRect: self.notchStackView.frame
            )
            diceView.frame = CGRect(origin: randomOrigin, size: Constants.diceSize)
            self.draggableViews.append(diceView)
            self.levelView.addSubview(diceView)
        }
    }

    func getRandomPointInRectExcludingArea(rect: CGRect, excludedRect: CGRect) -> CGPoint {
        var randomPoint: CGPoint

        repeat {
            let randomX = CGFloat.random(in: rect.minX...rect.maxX)
            let randomY = CGFloat.random(in: rect.minY...rect.maxY)
            randomPoint = CGPoint(x: randomX, y: randomY)
        } while excludedRect.contains(randomPoint)

        return randomPoint
    }

    @objc
    private func onDrag(_ gesture: UIPanGestureRecognizer) {
        guard let draggedView = gesture.view else { return }
        self.levelView.bringSubviewToFront(draggedView)

        let translation = gesture.translation(in: self.levelView)
        let viewCenterBounds = self.levelView.bounds.insetBy(dx: Constants.diceSize.width / 2, dy: Constants.diceSize.height / 2)
        let newCenterX = min(max(viewCenterBounds.minX, draggedView.center.x + translation.x), viewCenterBounds.maxX)
        let newCenterY = min(max(viewCenterBounds.minY, draggedView.center.y + translation.y), viewCenterBounds.maxY)
        draggedView.center = CGPoint(x: newCenterX, y: newCenterY)
        gesture.setTranslation(CGPoint.zero, in: self.levelView)

        if gesture.state == .ended {
            self.checkIfDicesInNotches()
        }
    }

    private func checkIfDicesInNotches() {
        guard !self.notchViews.isEmpty && !self.draggableViews.isEmpty else { return }

        var isCompleted = true

        for i in 0 ..< Constants.diceCount {
            let notchView = self.notchViews[i]
            let diceView = self.draggableViews[i]

            let notchFrameInLevelView = self.levelView.convert(notchView.frame, from: self.notchStackView)
            if CGRectIntersectsRect(notchFrameInLevelView, diceView.frame) && notchView.tag == diceView.tag {
                self.moveDiceToNotch(diceView: diceView, notchView: notchView)
            } else {
                isCompleted = false
            }
        }

        self.isLevelCompleted = isCompleted
    }

    private func moveDiceToNotch(diceView: UIView, notchView: UIView) {
        UIView.animate(withDuration: 0.1) {
            diceView.center = notchView.center
        }
    }
}
