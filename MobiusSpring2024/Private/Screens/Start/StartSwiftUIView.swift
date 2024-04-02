//
//  StartSwiftUIView.swift
//  MobiusSpring2024
//

import SwiftUI

struct StartSwiftUIView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .font(.largeTitle)
                .bold()
            
            Button("Press Me to Start!") {
                LevelBuilder.shared.currentLevel = 1
            }
            .buttonStyle(.bordered)
            .font(.title)
        }
    }
}

#Preview {
    StartSwiftUIView()
}
