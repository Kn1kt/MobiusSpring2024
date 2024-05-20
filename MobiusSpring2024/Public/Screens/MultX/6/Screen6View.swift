//
//  ContentView.swift
//  MobiusSpring2024
//

import SwiftUI

struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(size: 24, weight: .bold, design: .monospaced))
            .frame(width: 50, height: 50)
            .background(
                Color(
                    uiColor: configuration.isPressed
                    ? .secondarySystemBackground
                    : .tertiarySystemBackground
                ),
                in: RoundedRectangle(cornerRadius: 8)
            )
    }
}

struct KeyPadButton: View {
    var key: String
    
    var body: some View {
        Button(action: { self.action(self.key) }) {
            Text(key)
        }
        .padding(8)
        .buttonStyle(SimpleButtonStyle())
    }
    
    enum ActionKey: EnvironmentKey {
        static var defaultValue: (String) -> Void { { _ in } }
    }
    
    @Environment(\.keyPadButtonAction) var action: (String) -> Void
}

extension EnvironmentValues {
    var keyPadButtonAction: (String) -> Void {
        get { self[KeyPadButton.ActionKey.self] }
        set { self[KeyPadButton.ActionKey.self] = newValue }
    }
}

struct KeyPadRow: View {
    var keys: [String]
    
    var body: some View {
        HStack {
            ForEach(keys, id: \.self) { key in
                if key == "." {
                    KeyPadButton(key: key)
                        .hidden()
                } else {
                    KeyPadButton(key: key)
                }
            }
        }
    }
}

struct KeyPad: View {
    @Binding var string: String
    
    var body: some View {
        VStack {
            KeyPadRow(keys: ["1", "2", "3"])
            KeyPadRow(keys: ["4", "5", "6"])
            KeyPadRow(keys: ["7", "8", "9"])
            KeyPadRow(keys: [".", "0", "⌫"])
        }
        .environment(\.keyPadButtonAction, self.keyWasPressed(_:))
    }
    
    private func keyWasPressed(_ key: String) {
        switch key {
        case "." where string.contains("."): break
        case "." where string == "0": string += key
        case "⌫": if !string.isEmpty { string.removeLast() }
        default: string += key
        }
    }
}

struct Screen6View: View {
    @State private var generatedPassword = Self.generatePassword()
    @State private var enteredPassword = ""
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Y360Stack {
            if !orientation.isLandscape {
                Spacer()
                
                Text("Введите сгенерированный пароль")
                
                Text(generatedPassword)
                    .font(.largeTitle)
                
                Spacer()
                
                Text(enteredPassword.isEmpty ? "Введенный пароль" : enteredPassword)
                    .font(.largeTitle)
                    .foregroundStyle(enteredPassword.isEmpty ? .secondary : .primary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                
                Divider()
                
                KeyPad(string: $enteredPassword)
                    .onAppear {
                        generatedPassword = Self.generatePassword()
                    }
                
            } else {
                Spacer()
                
                Text("Введенный пароль")
                
                Text(enteredPassword)
                    .font(.largeTitle)
                    .padding(.bottom)
                
                Spacer()
                
                if generatedPassword == enteredPassword {
                    Button("Поехали дальше", action: action)
                        .buttonStyle(.borderedProminent)
                    
                    Spacer()
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            self.orientation = UIDevice.current.orientation
        }
    }
    
    private static func generatePassword() -> String {
        let range = 0 ..< 10
        return range.map { _ in String(Int.random(in: range)) }.shuffled().joined()
    }
}

struct Y360Stack<Content>: View where Content: View  {
    let content: Content
    
    @inlinable public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
//                .offset(y: 96)
        }
    }
}

#if DEBUG
struct Screen6View_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            Screen6View {}
        }
    }
}
#endif
