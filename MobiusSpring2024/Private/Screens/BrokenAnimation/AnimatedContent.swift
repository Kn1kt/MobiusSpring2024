//
//  AnimatedContainer.swift
//  MobiusSpring2024
//

import UIKit

public struct AnimatedContent {
    public static let zero: Self = .init(number: 0)
    public static let one: Self = .init(number: 1)
    public static let two: Self = .init(number: 2)
    public static let three: Self = .init(number: 3)
    public static let four: Self = .init(number: 4)
    public static let five: Self = .init(number: 5)
    public static let six: Self = .init(number: 6)
    public static let seven: Self = .init(number: 7)
    public static let eight: Self = .init(number: 8)
    public static let nine: Self = .init(number: 9)
    public static let ten: Self = .init(number: 10)
    
    public let boundsSize: CGSize
    public let shapes: [AnimatedShape]
    
    private init(number: Int) {
        let url = Bundle.main.url(forResource: "\(number)", withExtension: "txt")!
        let data = try! Data(contentsOf: url)
        let string = String(data: data, encoding: .utf8)!
        
        self.init(strings: string.split(separator: "\n").map { String($0) })
    }
    
    public init(strings: [String]) {
        let boundsSizeComponents = strings[0].split(separator: " ")
        self.boundsSize = CGSize(width: Double(boundsSizeComponents[0])!, height: Double(boundsSizeComponents[1])!)
        
        let shapesCount = Int(strings[1])!
        var currentIndex = 2
        
        self.shapes = (0 ..< shapesCount).map { _ in
            let shape = strings[currentIndex]
            let animationsCount = Int(strings[currentIndex + 1])!
            let animationsIndex = currentIndex + 2
            let animations = strings[animationsIndex ..< animationsIndex + animationsCount]
            
            defer { currentIndex += animationsCount + 2 }
            
            return AnimatedShape(shape: shape, animations: Array(animations))
        }
    }
}

extension AnimatedContent {
    public struct AnimatedShape {
        public let position: CGPoint
        public let boundsSize: CGSize
        public let cornerRadius: CGFloat
        
        public let rotationAngle: CGFloat
        
        public let color: UIColor
        
        public let animations: Set<AnyShapeAnimation>
        
        public init(shape: String, animations: [String]) {
            let shapeComponents = shape.split(separator: " ")
            let type = shapeComponents[0]
            
            switch type {
            case "rectangle":
                self.position = CGPoint(x: Double(shapeComponents[1])!, y: Double(shapeComponents[2])!)
                self.boundsSize = CGSize(width: Double(shapeComponents[3])!, height: Double(shapeComponents[4])!)
                self.cornerRadius = .zero
                self.rotationAngle = Double(shapeComponents[5])! * .pi / 180
                
            case "circle":
                self.position = CGPoint(x: Double(shapeComponents[1])!, y: Double(shapeComponents[2])!)
                self.boundsSize = CGSize(width: Double(shapeComponents[3])! * 2, height: Double(shapeComponents[3])! * 2)
                self.cornerRadius = Double(shapeComponents[3])!
                self.rotationAngle = .zero
                
            default:
                fatalError("Unexpected Shape Type")
            }
            
            self.color = switch shapeComponents.last! {
            case "black": .label
            case "red": .systemRed
            case "white": .systemGray6
            case "yellow": .systemYellow
            default: fatalError("Unexpected Rectangle Color")
            }
            
            self.animations = Set(animations.map { animation in
                let animationComponents = animation.split(separator: " ")
                let type = animationComponents[0]
                
                switch type {
                case "move":
                    let point = CGPoint(x: Double(animationComponents[1])!, y: Double(animationComponents[2])!)
                    let duration = Double(animationComponents[3])! / 1000
                    let repeated = animationComponents[safe: 4] == "cycle"
                    
                    return AnyShapeAnimation.move(point: point, duration: duration, repeated: repeated)
                case "rotate":
                    let angle = Double(animationComponents[1])! * .pi / 180
                    let duration = Double(animationComponents[2])! / 1000
                    let repeated = animationComponents[safe: 3] == "cycle"
                    
                    return AnyShapeAnimation.rotate(angle: angle, duration: duration, repeated: repeated)
                    
                case "scale":
                    let scale = Double(animationComponents[1])!
                    let duration = Double(animationComponents[2])! / 1000
                    let repeated = animationComponents[safe: 3] == "cycle"
                    
                    return AnyShapeAnimation.scale(scale: scale, duration: duration, repeated: repeated)
                    
                default:
                    fatalError("Unexpected Animtaion Type")
                }
            })
        }
    }
}
