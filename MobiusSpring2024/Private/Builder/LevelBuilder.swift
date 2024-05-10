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
            guard currentLevel == oldValue + 1 || currentLevel == 0 else { return }
            UserDefaults.standard.setValue(currentLevel, forKey: "LevelBuilder.CurrentLevelKey")
        }
    }
    
    @ObservationIgnored
    private static let levels: [UIViewController] = {
        let action: () -> Void = { LevelBuilder.shared.currentLevel += 1 }
        
        return [
            UIViewController(),  // empty controller
            BestIosQuestionViewController(action: action),
            UIHostingController(rootView: Screen6View(action: action))
        ]
    }()
    
    @ViewBuilder
    func buildView(for level: Int) -> some View {
        if level == .zero {
            StartSwiftUIView()
                .transition(.blurReplace)
            
        } else if let controller = Self.levels[safe: level] {
            AnyScreenLevel(controller: controller)
                .id(level)
                .transition(.push(from: .trailing))
            
        } else {
            FinishSwiftUIView()
                .transition(.blurReplace)
        }
    }
}

private struct AnyScreenLevel: UIViewControllerRepresentable {
    let controller: UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController { controller }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
