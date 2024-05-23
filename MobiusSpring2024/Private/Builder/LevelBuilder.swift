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
        let action: (Int) -> () -> Void = { level in { LevelBuilder.shared.currentLevel = level } }
        
        return [
            UIViewController(),  // empty controller
            ScreenViewController_1(action: action(2)),
            UIHostingController(rootView: ArinaScreenView(action: action(3))),
            BestIosQuestionViewController(action: action(4)),
            ScreenViewController_7(action: action(5)),
            UIHostingController(
                rootView: Screen6View {
                    generatePassword()
                } checkPassword: { password in
                    password == generatedPassword
                } tryPassword: { password in
                    guard password == generatedPassword else { return }
                    action(6)()
                }
            ),
            ScreenViewController_9(action: action(7)),
            ScreenViewController_3(action: action(8)),
            UIHostingController(
                rootView: AnimatedCaptchaContentView(animatedContent: .ten) { text in
                    guard text.lowercased() == "you are awesome" else { return }
                    action(9)()
                }
            ),
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

// MARK: - Password

private extension LevelBuilder {
    static var generatedPassword: String = "empty_password"
    
    static func generatePassword() -> String {
        let range = 1 ..< 10
        let digits = ["0"] + range.map { _ in String(Int.random(in: range)) }
        let password = digits.shuffled().joined()
        
        generatedPassword = password
        
        return password
    }
}

private struct AnyScreenLevel: UIViewControllerRepresentable {
    let controller: UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController { controller }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
