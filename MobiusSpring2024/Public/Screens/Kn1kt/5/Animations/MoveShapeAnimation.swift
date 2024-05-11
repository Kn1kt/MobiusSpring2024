//
//  MoveShapeAnimation.swift
//  MobiusSpring2024
//

import UIKit

struct MoveShapeAnimation: ShapeAnimation, ShapePropertyAnimation {
    static let keyPath = "position"

    private let point: CGPoint
    private let duration: CFTimeInterval
    private let repeated: Bool
     
    var body: CAAnimation {
        let animation = CABasicAnimation(keyPath: Self.keyPath)

        animation.toValue = point
        animation.duration = duration
        animation.repeatCount = repeated ? .greatestFiniteMagnitude : 1
        animation.preferredFrameRateRange = .frameRateForMovement

        return animation
    }
    
    fileprivate init(point: CGPoint, duration: CFTimeInterval, repeated: Bool) {
        self.point = point
        self.duration = duration
        self.repeated = repeated
    }
}

// MARK: - Move

public extension AnyShapeAnimation {
    static func move(point: CGPoint, duration: CFTimeInterval, repeated: Bool) -> Self {
        let move = MoveShapeAnimation(point: point, duration: duration, repeated: repeated)
        return .init(animation: move)
    }
}
