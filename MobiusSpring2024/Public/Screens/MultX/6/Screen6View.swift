//
//  ContentView.swift
//  MobiusSpring2024
//

import SwiftUI
import Internals

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
//                .offset(y: Constants.firstRowOffset)
            KeyPadRow(keys: ["4", "5", "6"])
//                .offset(y: Constants.secondRowOffset)
            KeyPadRow(keys: ["7", "8", "9"])
//                .offset(y: Constants.thirdRowOffset)
            KeyPadRow(keys: [".", "0", "⌫"])
//                .offset(y: Constants.fourthRowOffset)
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
    @State private var generatedPassword: Data
    @State private var enteredPassword: String
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    
    private let generatePassword: () -> Data
    private let checkPassword: (String) -> Bool
    private let tryPassword: (String) -> Void
    
    init(
        generatePassword: @escaping () -> Data,
        checkPassword: @escaping (String) -> Bool,
        tryPassword: @escaping (String) -> Void
    ) {
        self.generatePassword = generatePassword
        self.checkPassword = checkPassword
        self.tryPassword = tryPassword
        
        _generatedPassword = .init(wrappedValue: generatePassword())
        _enteredPassword = .init(wrappedValue: "")
    }
    
    var body: some View {
        VStack {
            if !orientation.isLandscape {
                Spacer()
                
                Text("Введите сгенерированный пароль")
                
                SecureText(generatedPassword)
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
                        generatedPassword = generatePassword()
                    }
                
            } else {
                Spacer()
                
                Text("Введенный пароль")
                
                Text(enteredPassword)
                    .font(.largeTitle)
                    .padding(.bottom)
                
                Spacer()
                
                if checkPassword(enteredPassword) {
                    Button("Продолжить") {
                        tryPassword(enteredPassword)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            self.orientation = UIDevice.current.orientation
        }
    }
}

private enum Constants {
    static let firstRowOffset: CGFloat = 16
    static let secondRowOffset: CGFloat = 46
    static let thirdRowOffset: CGFloat = 76
    static let fourthRowOffset: CGFloat = 106
}

#Preview {
    Screen6View {
        Data()
    } checkPassword: { _ in
        true
    } tryPassword: { _ in
    }
}
