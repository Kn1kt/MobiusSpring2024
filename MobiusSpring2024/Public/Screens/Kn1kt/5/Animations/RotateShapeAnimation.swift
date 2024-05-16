//
//  RotateShapeAnimation.swift
//  MobiusSpring2024
//

import UIKit

struct RotateShapeAnimation: ShapeAnimation, ShapePropertyAnimation {
    static let keyPath = "transform.rotation.z"

    private let angle: CGFloat
    private let duration: CFTimeInterval
    private let repeated: Bool
    
    var body: CAAnimation {
        let animation = CABasicAnimation(keyPath: Self.keyPath)
        
        animation.byValue = angle
        animation.duration = duration
        animation.repeatCount = repeated ? .greatestFiniteMagnitude : 1
        animation.preferredFrameRateRange = .frameRateForMovement

        return animation
    }
    
    fileprivate init(angle: CGFloat, duration: CFTimeInterval, repeated: Bool) {
        self.angle = angle
        self.duration = duration
        self.repeated = repeated
    }
}

// MARK: - Rotate

public extension AnyShapeAnimation {
    static func rotate(angle: CGFloat, duration: CFTimeInterval, repeated: Bool) -> Self {
        let rotate = RotateShapeAnimation(angle: angle, duration: duration, repeated: repeated)
        return .init(animation: rotate)
    }
}

// MARK: - Helpers

extension CATransform3D {
    static func rotate(_ angle: CGFloat) -> CATransform3D {
        let transform = CGAffineTransform(rotationAngle: angle)
        return CATransform3DMakeAffineTransform(transform)
    }
}
