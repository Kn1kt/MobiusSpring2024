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
    
    @ViewBuilder
    func buildView(for level: Int) -> some View {
        switch level {
        case 0: 
            StartSwiftUIView()
            
        case 1:
            AnyScreenLevel(controller: ScreenViewController_1())
            
        case 2:
            AnyScreenLevel(controller: ScreenViewController_2())
            
        case 3:
            AnyScreenLevel(controller: ScreenViewController_3())
            
        default:
            FinishSwiftUIView()
        }
    }
}

private struct AnyScreenLevel: UIViewControllerRepresentable {
    let controller: UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController { controller }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
