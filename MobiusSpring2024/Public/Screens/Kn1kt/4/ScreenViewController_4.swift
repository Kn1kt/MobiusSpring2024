//
//  ScreenViewController_4.swift
//  MobiusSpring2024
//

import UIKit

final class ScreenViewController_4: BaseScreenViewController {
    private lazy var question: UILabel = {
        let label = UILabel()
        label.text = "Введите ваш возраст:"
        label.textAlignment = .center
        
        view.addSubview(label)
        
        return label
    }()
    
    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        view.addSubview(picker)
        
        return picker
    }()
    
    private lazy var confirm: UIView = {
        let action = UIAction(title: "Подтвердить") { [weak self] _ in
            self?.checkConfirmation()
        }
        let button = UIButton(configuration: .borderedTinted(), primaryAction: action)
        button.layer.cornerRadius = 8
        
        view.addSubview(button)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapMeButton.isHidden = true
        
        layoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    
    }
    
    private func layoutSubviews() {
        [confirm, question, picker].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            question.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            question.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            picker.topAnchor.constraint(equalToSystemSpacingBelow: question.bottomAnchor, multiplier: 1.0),
            picker.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            confirm.topAnchor.constraint(equalToSystemSpacingBelow: picker.bottomAnchor, multiplier: 1.0),
            confirm.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    private func playErrorAnimation() {
        let anim1 = CAKeyframeAnimation(keyPath: "backgroundColor")
        anim1.values = [UIColor.clear.cgColor, UIColor.red.cgColor, UIColor.clear.cgColor]
        anim1.keyTimes = [0.0, 0.1, 0.9, 1.0]
        anim1.fillMode = .forwards
        anim1.isAdditive = true
        anim1.isRemovedOnCompletion = true
        
        let transforms: [CATransform3D] = [
            .moveLeft(),
            .moveRight(),
            .moveLeft(),
            .moveRight(),
            .moveLeft(),
            .moveRight(),
        ]
        let anim2 = CAKeyframeAnimation(keyPath: "transform")
        anim2.values = transforms
        anim2.keyTimes = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
        anim2.fillMode = .forwards
        anim2.isAdditive = true
        anim2.isRemovedOnCompletion = true
        
        let group = CAAnimationGroup()
        group.animations = [anim1, anim2]
        group.fillMode = .forwards
        group.isRemovedOnCompletion = false
        group.delegate = self
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        confirm.isUserInteractionEnabled = false
        confirm.layer.add(group, forKey: "animation_key_\(attempts)")
        CATransaction.commit()
    }
    
    private var attempts: Int = 0
    private func checkConfirmation() {
        attempts += 1
        guard attempts > 15 else { return playErrorAnimation() }
        tapMeButton.performPrimaryAction()
    }
}

extension ScreenViewController_4: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
}

extension ScreenViewController_4: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titles: [String] = (1 ... 100).map { "\($0)"}
        return titles[row]
    }
}

extension ScreenViewController_4: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        confirm.isUserInteractionEnabled = flag
    }
}

extension CATransform3D {
    static func moveLeft() -> CATransform3D {
        let transform = CGAffineTransform(translationX: -30, y: 0)
        return CATransform3DMakeAffineTransform(transform)
    }
    
    static func moveRight() -> CATransform3D {
        let transform = CGAffineTransform(translationX: 30, y: 0)
        return CATransform3DMakeAffineTransform(transform)
    }
    
    static func translate(x: CGFloat, y: CGFloat) -> CATransform3D {
        let transform = CGAffineTransform(translationX: x, y: y)
        return CATransform3DMakeAffineTransform(transform)
    }
    
    static func scale(x: CGFloat, y: CGFloat) -> CATransform3D {
        let transform = CGAffineTransform(scaleX: x, y: y)
        return CATransform3DMakeAffineTransform(transform)
    }
}
