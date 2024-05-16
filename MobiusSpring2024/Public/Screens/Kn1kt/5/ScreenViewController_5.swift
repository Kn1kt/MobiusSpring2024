//
//  ScreenViewController_5.swift
//  MobiusSpring2024
//

import UIKit

final class ScreenViewController_5: BaseScreenViewController {
    private let animatedContainer = {
        let url = Bundle.main.url(forResource: "10", withExtension: "txt")!
        let data = try! Data(contentsOf: url)
        let string = String(data: data, encoding: .utf8)!
        return AnimatedContainer(strings: string.split(separator: "\n").map { String($0) })
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = -10
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.isEnabled = false
        slider.translatesAutoresizingMaskIntoConstraints = false
                
        return slider
    }()
    
    private lazy var pause: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.addTarget(self, action: #selector(didTapPauseButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
                
        return button
    }()
    
    private var beginTime: CFTimeInterval?
    private var originTimeOffset: CFTimeInterval?
    private var animatedLayer: AnimatedLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapMeButton.isHidden = true
        
        view.addSubview(slider)
        view.addSubview(pause)
        
        NSLayoutConstraint.activate([
            pause.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1.0),
            pause.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
            
            slider.leadingAnchor.constraint(equalToSystemSpacingAfter: pause.trailingAnchor, multiplier: 1.0),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: slider.trailingAnchor, multiplier: 1.0),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: slider.bottomAnchor, multiplier: 1.0),
        ])
        
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (traitEnvironment: Self, _) in
            traitEnvironment.setupAnimatedLayer()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let scale = view.safeAreaLayoutGuide.layoutFrame.width / animatedContainer.boundsSize.width
        
        animatedLayer?.position = view.layer.position
        animatedLayer?.transform = .scale(x: scale, y: scale)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupAnimatedLayer()
    }
    
    private func setupAnimatedLayer() {
        let previousAnimatedLayer = animatedLayer
        let animatedLayer = AnimatedLayer()
        animatedLayer.bounds.size = animatedContainer.boundsSize
                
        view.layer.addSublayer(animatedLayer)
        
        let beginTime = beginTime ?? animatedLayer.convertTime(CACurrentMediaTime(), from: nil)
        
        for shape in animatedContainer.animatedShapes {
            let shapeLayer = AnimatedLayer()
            shapeLayer.position = shape.position
            shapeLayer.bounds.size = shape.boundsSize
            shapeLayer.cornerRadius = shape.cornerRadius
            shapeLayer.transform = .rotate(shape.rotationAngle)
            shapeLayer.backgroundColor = shape.color.cgColor
            
            animatedLayer.addSublayer(shapeLayer)
            
            for (index, animation) in shape.animations.enumerated() {
                let body = animation.body
                body.beginTime = beginTime
                body.isRemovedOnCompletion = false
                body.fillMode = .forwards

                shapeLayer.add(body, forKey: String(index))
            }
        }
        
        self.animatedLayer?.removeFromSuperlayer()
        self.animatedLayer = animatedLayer
        self.beginTime = beginTime
        
        if let previousAnimatedLayer, originTimeOffset != nil {
            animatedLayer.pauseAnimations()
            sliderValueChanged()
        }
    }
    
    @objc
    private func sliderValueChanged() {
        guard let originTimeOffset else { return }
        animatedLayer?.timeOffset = originTimeOffset + Double(slider.value)
    }
    
    @objc
    private func didTapPauseButton() {
        guard let animatedLayer else { return }
        
        if animatedLayer.isPaused {
            animatedLayer.resumeAnimations()
            originTimeOffset = nil
        } else {
            animatedLayer.pauseAnimations()
            originTimeOffset = animatedLayer.timeOffset
        }
        
        slider.isEnabled = animatedLayer.isPaused
        slider.value = 0
        pause.setImage(UIImage(systemName: animatedLayer.isPaused ? "play.fill" : "pause.fill"), for: .normal)
    }
}
