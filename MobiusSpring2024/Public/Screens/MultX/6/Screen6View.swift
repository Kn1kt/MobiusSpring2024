//
//  ContentView.swift
//  mobius
//
//  Created by Mikhail Buravlev on 07.05.2024.
//

import SwiftUI

struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(size: 24, weight: .bold, design: .monospaced))
            .frame(width: 50, height: 50)
            .foregroundColor(Color(red: 97/255, green: 97/255, blue: 97/255))
            .background(
                Color(uiColor: configuration.isPressed ? .secondarySystemBackground: .tertiarySystemBackground), in: RoundedRectangle(cornerRadius: 8)
            )
    }
}

struct KeyPadButton: View {
    var key: String

    var body: some View {
        Button(action: { self.action(self.key) }) {
            Text(key)
        }
        .frame(width: 64, height: 64)
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
            .padding(.bottom, 32)
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

struct Screen6View : View {
    @State private var generatedPassword = ""
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
                    .padding(.top)
                Text(generatedPassword)
                    .font(.largeTitle)
                    .padding(.bottom)
                Spacer()
                HStack {
                    Spacer()
                    Text(enteredPassword)
                        .font(.largeTitle)
                            .padding()
                }.padding([.leading, .trailing])
                Divider()
                KeyPad(string: $enteredPassword)
                .onAppear {
                    generatePassword()
                }
            } else {
                Text("Введенный пароль")
                    .padding(.top, 32)
                Text(enteredPassword)
                    .font(.largeTitle)
                    .padding(.bottom)
                
                Spacer()
                if generatedPassword == enteredPassword {
                    Button("Поехали дальше", action: action)
                    .buttonStyle(.borderedProminent)
                    .padding(64)
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            self.orientation = UIDevice.current.orientation
        }
    }

    private func generatePassword() {
        let range = 0 ..< 10
        generatedPassword = range.map { _ in String(Int.random(in: range)) }.shuffled().joined()
    }
}

struct Y360Stack<Content>: View where Content : View  {
    var content: () -> Content
    
    @inlinable public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        VStack {
            content()
        }
        .offset(y: 128)
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
