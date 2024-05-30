//
//  AnimatedCaptchaContentView.swift
//  MobiusSpring2024
//

import UIKit
import SwiftUI
import Internals

struct AnimatedCaptchaContentView: View {
    let animatedContent: AnimatedContent
    let action: (String) -> Void
    
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            AnimatedCaptchaContent(controller: AnimatedContentScreen(animatedContent: animatedContent))
                        
            Text("Мы все еще не уверены, что вы не робот")
                .font(.title2)
            
            TextField(text: $text, prompt: Text("Введите текст с картинки")) {
                EmptyView()
            }
            .font(.title3)
            
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding()
        .onChange(of: text) { _, newValue in action(newValue) }
    }
}

private struct AnimatedCaptchaContent: UIViewControllerRepresentable {
    let controller: UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController { controller }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

#Preview {
    AnimatedCaptchaContentView(animatedContent: .ten, action: { _ in })
}
