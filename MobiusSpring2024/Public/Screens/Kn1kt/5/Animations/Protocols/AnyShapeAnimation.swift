//
//  AnyShapeAnimation.swift
//  MobiusSpring2024
//

import UIKit

public struct AnyShapeAnimation: ShapeAnimation {
    public typealias Animation = ShapeAnimation & ShapePropertyAnimation

    public var body: CAAnimation { animation.body }
    
    private let animation: any Animation

    public init(animation: some Animation) {
        self.animation = animation
    }
}

// MARK: - Hashable

extension AnyShapeAnimation: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return type(of: lhs.animation).keyPath == type(of: rhs.animation).keyPath
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(type(of: animation).keyPath)
    }
}
