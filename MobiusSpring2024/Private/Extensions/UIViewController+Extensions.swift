//
//  UIViewController+Extensions.swift
//  MobiusSpring2024
//

import UIKit

extension UIViewController {
    var level: Int { String(describing: type(of: self)).split(separator: "_").last.flatMap { Int($0) }! }
}
