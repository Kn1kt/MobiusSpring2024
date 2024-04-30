//
//  ContentView.swift
//  MobiusSpring2024
//

import SwiftUI

struct ContentView: View {
    @State private var state = LevelBuilder.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                state.buildView(for: state.currentLevel)
                    .ignoresSafeArea()
                    .navigationTitle("\(state.currentLevel)")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Reset", systemImage: "arrow.circlepath", role: .cancel) {
                                state.currentLevel = 0
                            }
                        }
                    }
            }
            .animation(.default, value: state.currentLevel)
        }
    }
}

#Preview {
    ContentView()
}
