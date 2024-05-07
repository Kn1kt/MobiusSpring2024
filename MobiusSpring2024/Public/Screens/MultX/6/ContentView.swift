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
                Group {
                    if configuration.isPressed {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color(red: 240/255, green: 240/255, blue: 240/255))
                    } else {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color(red: 240/255, green: 240/255, blue: 240/255))
                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 2, y: 2)
                            .shadow(color: Color.white.opacity(0.7), radius: 4, x: -1, y: -1)
                    }
                }
                
                
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
                .padding(32)
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

struct ContentView : View {
    @State private var generatedPassword = ""
    @State private var enteredPassword = ""
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    
    private let successAction: () -> Void
    
    init(successAction: () -> Void) {
        self.successAction = successAction
    }
    
    var body: some View {
        ZStack {
            Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
            VStack {
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
                } else {

                    Text("Введенный пароль")
                        .padding(.top, 32)
                    Text(enteredPassword)
                        .font(.largeTitle)
                        .padding(.bottom)
                    
                    Spacer()
                    if generatedPassword == enteredPassword {
                        Button("Поехали дальше", action: successAction)
                        .buttonStyle(.borderedProminent)
                        .padding(64)
                    }
                }
            }
            .offset(y: 128)
            .onAppear {
                generatePassword()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            self.orientation = UIDevice.current.orientation
        }
    }

    private func generatePassword() {
        var password = ""
        let digits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        
        password += "0"
        for _ in 1...10 {
            let randomIndex = Int.random(in: 0..<digits.count)
            password += digits[randomIndex]
        }
        
        generatedPassword = String(Array(password).shuffled())
    }
}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
#endif
