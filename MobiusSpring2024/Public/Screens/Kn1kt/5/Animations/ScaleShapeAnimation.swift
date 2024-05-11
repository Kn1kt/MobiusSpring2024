//
//  ScaleShapeAnimation.swift
//  MobiusSpring2024
//

import UIKit

struct ScaleShapeAnimation: ShapeAnimation, ShapePropertyAnimation {
    static let keyPath = "transform.scale"

    private let scale: CGFloat
    private let duration: CFTimeInterval
    private let repeated: Bool
     
    var body: CAAnimation {
        let animation = CABasicAnimation(keyPath: Self.keyPath)

        animation.toValue = scale
        animation.duration = duration
        animation.repeatCount = repeated ? .greatestFiniteMagnitude : 1
        animation.preferredFrameRateRange = .frameRateForMovement
        
        return animation
    }
    
    fileprivate init(scale: CGFloat, duration: CFTimeInterval, repeated: Bool) {
        self.scale = scale
        self.duration = duration
        self.repeated = repeated
    }
}

// MARK: - Scale

public extension AnyShapeAnimation {
    static func scale(scale: CGFloat, duration: CFTimeInterval, repeated: Bool) -> Self {
        let scale = ScaleShapeAnimation(scale: scale, duration: duration, repeated: repeated)
        return .init(animation: scale)
    }
}
