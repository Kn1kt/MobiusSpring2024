//
//  AnimatedContainer.swift
//  MobiusSpring2024
//

import UIKit

struct AnimatedContainer {
    let boundsSize: CGSize
    let animatedShapes: [AnimatedShape]
    
    init(strings: [String]) {
        let boundsSizeComponents = strings[0].split(separator: " ")
        self.boundsSize = CGSize(width: Double(boundsSizeComponents[0])!, height: Double(boundsSizeComponents[1])!)
        
        let shapesCount = Int(strings[1])!
        var currentIndex = 2
        
        self.animatedShapes = (0 ..< shapesCount).map { _ in
            let shape = strings[currentIndex]
            let animationsCount = Int(strings[currentIndex + 1])!
            let animationsIndex = currentIndex + 2
            let animations = strings[animationsIndex ..< animationsIndex + animationsCount]
            
            defer { currentIndex += animationsCount + 2 }
            
            return AnimatedShape(shape: shape, animations: Array(animations))
        }
    }
}

extension AnimatedContainer {
    struct AnimatedShape {
        let position: CGPoint
        let boundsSize: CGSize
        let cornerRadius: CGFloat
        
        let rotationAngle: CGFloat
        
        let color: UIColor
        
        let animations: Set<AnyShapeAnimation>
        
        init(shape: String, animations: [String]) {
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
