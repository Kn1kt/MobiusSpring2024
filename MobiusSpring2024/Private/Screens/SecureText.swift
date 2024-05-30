//
//  SecureText.swift
//  MobiusSpring2024
//

import SwiftUI
import CryptoKit

public struct SecureText: View {
    private let text: String
    
    public var body: some View {
        Text(text)
    }
    
    public init(_ data: Data) {
        self.text = Self.decrypt(input: data)
    }
}

#Preview {
    SecureText(SecureText.encrypt(input: ""))
}


extension SecureText {
    private static let key: String = (0 ..< 4)
        .map { _ in Array(repeating: "\(Int.random(in: 0 ..< 100))", count: 8).joined() }
        .joined()
    
    static func encrypt(input: String) -> Data {
        let input = input.data(using: .utf8)!
        let keyData = Data(key.data(using: .utf8)!.prefix(32))
        let key = SymmetricKey(data: keyData)
        let sealed = try! AES.GCM.seal(input, using: key)
        return sealed.combined!
    }
    
    static func decrypt(input: Data) -> String {
        let keyData = Data(key.data(using: .utf8)!.prefix(32))
        let key = SymmetricKey(data: keyData)
        let box = try! AES.GCM.SealedBox(combined: input)
        let opened = try! AES.GCM.open(box, using: key)
        return String(data: opened, encoding: .utf8) ?? ""
    }
}
