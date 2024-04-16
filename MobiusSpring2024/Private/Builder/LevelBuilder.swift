//
//  LevelBuilder.swift
//  MobiusSpring2024
//

import UIKit
import Observation
import SwiftUI

@Observable
final class LevelBuilder {
    static let shared: LevelBuilder = .init()
    
    var currentLevel: Int = UserDefaults.standard.integer(forKey: "LevelBuilder.CurrentLevelKey") {
        didSet {
//            let maxLevel = max(currentLevel, oldValue)
            UserDefaults.standard.setValue(currentLevel, forKey: "LevelBuilder.CurrentLevelKey")
        }
    }
    
    @ObservationIgnored
    private lazy var levels: [UIViewController] = {
        let action: () -> Void = { [weak self] in self?.currentLevel += 1 }
        return [
            UIViewController(),  // empty controller
            BestIosQuestionViewController(action: action)
        ]
    }()
    
    @ViewBuilder
    func buildView(for level: Int) -> some View {
        if level == 0 {
            StartSwiftUIView()
        } else if let controller = levels[safe: level]  {
            AnyScreenLevel(controller: controller)
        } else {
            FinishSwiftUIView()
        }
    }
}

private struct AnyScreenLevel: UIViewControllerRepresentable {
    let controller: UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController { controller }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

extension Array {
    subscript(safe index: Int) -> Element? {
        get { return index < count ? self[index] : nil }
    }
}
