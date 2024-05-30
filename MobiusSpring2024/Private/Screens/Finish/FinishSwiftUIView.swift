//
//  FinishSwiftUIView.swift
//  MobiusSpring2024
//

import SwiftUI

struct FinishSwiftUIView: View {
    @State private var toggle: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "face.dashed")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .symbolRenderingMode(.hierarchical)
                .symbolEffect(.bounce, options: .repeating.repeat(3), value: toggle)
                .foregroundStyle(.tint)
            
            Spacer()
            
            Text("Поздравляем,\nвы не робот!")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
        }
        .padding()
        .onAppear { toggle.toggle() }
    }
}

#Preview {
    FinishSwiftUIView()
}
