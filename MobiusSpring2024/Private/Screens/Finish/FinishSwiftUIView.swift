//
//  FinishSwiftUIView.swift
//  MobiusSpring2024
//

import SwiftUI

struct FinishSwiftUIView: View {
    var body: some View {
        VStack {
            Image(systemName: "fireworks")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(.tint)
            
            Text("You are Win!")
                .font(.largeTitle)
                .bold()
        }
        .padding()
    }
}

#Preview {
    FinishSwiftUIView()
}
