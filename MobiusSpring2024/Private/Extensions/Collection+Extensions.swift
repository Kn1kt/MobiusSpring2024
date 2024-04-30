//
//  Collection+Extensions.swift
//  MobiusSpring2024
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
