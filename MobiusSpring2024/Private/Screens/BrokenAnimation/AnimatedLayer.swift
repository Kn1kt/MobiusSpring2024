//
//  AnimatedLayer.swift
//  MobiusSpring2024
//

import UIKit

public final class AnimatedLayer: CALayer {
    private(set) var isPaused: Bool = false
    private var originSpeed: Float = 1.0
    
    override public func action(forKey _: String) -> (any CAAction)? { NSNull() }
    
    public func pauseAnimations() {
        guard !isPaused else { return }
        defer { isPaused = true }

        let pausedTime = currentLocalTime

        originSpeed = speed
        speed = .zero
        timeOffset = pausedTime
    }

    public func resumeAnimations() {
        guard isPaused else { return }
        defer { isPaused = false }

        let pausedTime = timeOffset

        speed = originSpeed
        timeOffset = .zero
        beginTime = .zero

        let timeSincePause = currentLocalTime - pausedTime
        beginTime = convertToParentDuration(timeSincePause)
    }
}

private extension AnimatedLayer {
    @inline(__always) 
    var currentLocalTime: CFTimeInterval { convertToLocalTime(CACurrentMediaTime()) }

    @inline(__always)
    func convertToParentDuration(_ duration: CFTimeInterval) -> CFTimeInterval {
        let zeroTime = convertTime(.zero, to: superlayer)
        let convertedDuration = convertTime(duration, to: superlayer)
        return convertedDuration - zeroTime
    }

    @inline(__always)
    func convertToLocalTime(_ time: CFTimeInterval) -> CFTimeInterval {
        return convertTime(time, from: nil)
    }
}
