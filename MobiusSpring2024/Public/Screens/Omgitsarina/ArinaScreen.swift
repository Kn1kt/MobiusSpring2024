//
//  ArinaScreen.swift
//  MobiusSpring2024
//
//  Created by Arina Bykova on 15.05.2024.
//

import SwiftUI

struct ArinaScreenView: View {
    @State private var birthDate = Date.now
    
    let action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            DatePicker(
                selection: $birthDate,
                in: Date.now...,
                displayedComponents: .date
            ) {
                VStack(alignment: .leading) {
                    Text("Выбери дату рождения")
                        .font(.body)
                    
                    Text("Твоя дата рождения \(birthDate.formatted(date: .long, time: .omitted))")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            Button {
                if birthDate == Date(timeIntervalSince1970: .zero) {
                    action()
                }
            } label: {
                Text("OK")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

#Preview {
    ArinaScreenView(action: {})
}
