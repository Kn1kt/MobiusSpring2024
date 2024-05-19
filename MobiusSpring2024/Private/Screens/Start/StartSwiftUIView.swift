//
//  StartSwiftUIView.swift
//  MobiusSpring2024
//

import SwiftUI

struct StartSwiftUIView: View {
    var body: some View {
        VStack {
            Text("Подтвердите, что вы не робот, ответив на пару простых вопрсов")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            
            Button("Начать!") {
                LevelBuilder.shared.currentLevel = 1
            }
            .buttonStyle(.bordered)
            .font(.title2)
            .bold()
        }
        .padding()
    }
}

#Preview {
    StartSwiftUIView()
}
