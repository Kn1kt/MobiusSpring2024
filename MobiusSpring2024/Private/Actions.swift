//
//  Actions.swift
//  MobiusSpring2024
//
//  Created by Ilya Zasimov on 11.04.2024.
//

import Foundation
enum Actions {
    enum Level4 {
        private static var data: Int = 0
        
        private static func calcFibonachiFast(_ n: Int ) -> Int{
            var cache: [Int] = [0, 1]
            var i = 0
            while i < n - 2 {
                cache.append(cache[i] + cache[i + 1])
                i+=1
            }
            if n == 0 { return 0 }
            if n == 1 || n == 2 { return 1 }
            return cache[i] + cache[i+1]
        }
        
        static func getCalculationData() -> Int {
            data = (88...92).randomElement()!
            return data
        }
        
        static func check(result: UInt64) -> Bool {
            if result == calcFibonachiFast(data) {
                LevelBuilder.shared.currentLevel += 1
                return true
            } else {
                return false
            }
        }
    }
}
