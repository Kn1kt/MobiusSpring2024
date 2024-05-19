//
//  DEBUGAnimatedContentScreen.swift
//  MobiusSpring2024
//

import UIKit

open class DEBUGAnimatedContentScreen: UIViewController {
    public let animatedContent: AnimatedContent
    
    public final var animatedLayer: AnimatedLayer?
    
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
    
    private var originTimeOffset: CFTimeInterval?
    
    public init(animatedContent: AnimatedContent) {
        self.animatedContent = animatedContent
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
#if DEBUG
        view.addSubview(slider)
        view.addSubview(pause)
        
        NSLayoutConstraint.activate([
            pause.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1.0),
            pause.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
            
            slider.leadingAnchor.constraint(equalToSystemSpacingAfter: pause.trailingAnchor, multiplier: 1.0),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: slider.trailingAnchor, multiplier: 1.0),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: slider.bottomAnchor, multiplier: 1.0),
        ])
#endif
    }
    
    open func setupAnimatedLayer() {
        guard originTimeOffset != nil else { return }
        
        animatedLayer?.pauseAnimations()
        sliderValueChanged()
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
