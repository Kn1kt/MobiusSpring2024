//
//  ArinaScreen.swift
//  MobiusSpring2024
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
                let year = Calendar.current.component(.year, from: birthDate)
                let currentYear = Calendar.current.component(.year, from: .now)
                guard currentYear - year >= 18 else { return }
                action()
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
