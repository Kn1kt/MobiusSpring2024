//
//  ShapePropertyAnimation.swift
//  MobiusSpring2024
//

import UIKit

public protocol ShapePropertyAnimation {
    static var keyPath: String { get }
}

// MARK: - Animation

public protocol ShapeAnimation {
    var body: CAAnimation { get }
}
