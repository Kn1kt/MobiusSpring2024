//
//  MobiusSpring2024App.swift
//  MobiusSpring2024
//

import SwiftUI
import Internals

@main
struct MobiusSpring2024App: App {
    init() {
        if LevelBuilder.levels.isEmpty {
            LevelBuilder.levels = [
                UIViewController(),  // empty controller
                ScreenViewController_1(action: LevelBuilder.makeAction(for: 2)),
                UIHostingController(rootView: ArinaScreenView(action: LevelBuilder.makeAction(for: 3))),
                BestIosQuestionViewController(action: LevelBuilder.makeAction(for: 4)),
                ScreenViewController_7(action: LevelBuilder.makeAction(for: 5)),
                UIHostingController(
                    rootView: Screen6View {
                        LevelBuilder.generatePassword()
                    } checkPassword: { password in
                        LevelBuilder.checkPassword(password: password)
                    } tryPassword: { password in
                        LevelBuilder.tryPassword(password: password)
                    }
                ),
                ScreenViewController_9(action: LevelBuilder.makeAction(for: 7)),
                ScreenViewController_3(action: LevelBuilder.makeAction(for: 8)),
                UIHostingController(
                    rootView: AnimatedCaptchaContentView(animatedContent: .ten) { text in
                        LevelBuilder.validateAnimation(.ten, text: text)
                    }
                ),
            ]
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
