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
            
            Button {
                LevelBuilder.shared.currentLevel = 1
            } label: {
                Text("Начать")
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
