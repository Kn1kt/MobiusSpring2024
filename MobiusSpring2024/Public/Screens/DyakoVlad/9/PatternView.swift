//
//  PatternView.swift
//  MobiusSpring2024
//

import UIKit

protocol PatternViewDelegate: AnyObject {
    func patternCompleted(pattern: [Int])
}

final class PatternView: UIView {
    private var dotViews: [UIView] = []
    private var selectedDotViews: [UIView] = []
    private var currentPoint: CGPoint?
    private let gridSize: Int = 3

    weak var delegate: PatternViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupDots()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupDots()
    }

    private func setupDots() {
        let dotSize: CGFloat = 60
        let padding: CGFloat = 40
        let totalWidth = CGFloat(self.gridSize) * dotSize + CGFloat(self.gridSize - 1) * padding
        let startX = (self.frame.width - totalWidth) / 2
        let startY = (self.frame.height - totalWidth) / 2

        for row in 0 ..< self.gridSize {
            for col in 0 ..< self.gridSize {
                let x = startX + CGFloat(col) * (dotSize + padding)
                let y = startY + CGFloat(row) * (dotSize + padding)
                let dotView = UIView(frame: CGRect(x: x, y: y, width: dotSize, height: dotSize))
                
                self.addSubview(dotView)
                self.dotViews.append(dotView)
                
                dotView.backgroundColor = .secondarySystemBackground
                dotView.layer.cornerRadius = dotSize / 2
                dotView.layer.masksToBounds = true
//                dotView.layer.isGeometryFlipped = true
//                dotView.layer.superlayer?.isGeometryFlipped = true
                dotView.tag = row * self.gridSize + col + 1

                let label = UILabel(frame: dotView.bounds)
                label.text = "\(dotView.tag)"
                label.font = .systemFont(ofSize: 24, weight: .semibold)
                label.textAlignment = .center
                dotView.addSubview(label)
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: nil)
            if let dotView = self.dotViewAtPoint(point), !self.selectedDotViews.contains(dotView) {
                selectedDotViews.append(dotView)
                dotView.backgroundColor = .tintColor
                self.setNeedsDisplay()
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: nil)
            self.currentPoint = point
            if let dotView = self.dotViewAtPoint(point), !self.selectedDotViews.contains(dotView) {
                self.selectedDotViews.append(dotView)
                dotView.backgroundColor = .tintColor
            }
            self.setNeedsDisplay()
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentPoint = nil
        self.setNeedsDisplay()
        self.validatePattern()
        self.resetPattern()
    }

    private func dotViewAtPoint(_ point: CGPoint) -> UIView? {
        return self.dotViews.first { $0.frame.contains(point) }
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setStrokeColor(UIColor.tintColor.cgColor)
        context.setLineWidth(5)

        if self.selectedDotViews.isEmpty { return }

        context.move(to: self.selectedDotViews.first!.center)
        for dotView in self.selectedDotViews {
            context.addLine(to: dotView.center)
        }

        if let currentPoint = currentPoint {
            context.addLine(to: currentPoint)
        }

        context.strokePath()
    }

    private func validatePattern() {
        let pattern = self.selectedDotViews.map { $0.tag }
        self.delegate?.patternCompleted(pattern: pattern)
    }

    private func resetPattern() {
        for dotView in self.selectedDotViews {
            dotView.backgroundColor = .secondarySystemBackground
        }
        self.selectedDotViews.removeAll()
        self.setNeedsDisplay()
    }
}
