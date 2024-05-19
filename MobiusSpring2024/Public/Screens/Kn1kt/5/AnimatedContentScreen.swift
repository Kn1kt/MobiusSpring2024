//
//  AnimatedContentScreen.swift
//  MobiusSpring2024
//

import UIKit

final class AnimatedContentScreen: DEBUGAnimatedContentScreen {
    private var beginTime: CFTimeInterval?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (traitEnvironment: Self, _) in
            traitEnvironment.setupAnimatedLayer()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layoutAnimatedLayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupAnimatedLayer()
    }
    
    override func setupAnimatedLayer() {
        let animatedLayer = AnimatedLayer()
        animatedLayer.bounds.size = animatedContent.boundsSize
        
        view.layer.addSublayer(animatedLayer)
        
        let beginTime = beginTime ?? animatedLayer.convertTime(CACurrentMediaTime(), from: nil)
        
        for shape in animatedContent.shapes {
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
        
        layoutAnimatedLayer()
        
        super.setupAnimatedLayer()
    }
    
    private func layoutAnimatedLayer() {
        let scale = view.safeAreaLayoutGuide.layoutFrame.width / animatedContent.boundsSize.width
        
        animatedLayer?.position = .init(x: view.bounds.midX, y: view.bounds.midY)
        animatedLayer?.transform = .scale(x: scale, y: scale)
    }
}
