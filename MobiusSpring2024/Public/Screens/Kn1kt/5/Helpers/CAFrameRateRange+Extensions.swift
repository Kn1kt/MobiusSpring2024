//
//  CAFrameRateRange+Extensions.swift
//  MobiusSpring2024
//

import UIKit

// https://developer.apple.com/documentation/quartzcore/optimizing_promotion_refresh_rates_for_iphone_13_pro_and_ipad_pro#3885326
extension CAFrameRateRange {
    static let frameRateForMovement: Self = .init(minimum: 80.0, maximum: 120.0, preferred: 120.0)
    static let frameRateForBlending: Self = .default
}
