//
//  ScreenViewController_7.swift
//  MobiusSpring2024
//

import Foundation
import UIKit

final class ScreenViewController_7: BaseScreenViewController {
    private lazy var titleView: UILabel = {
        let titleView = UILabel()
        self.view.addSubview(titleView)
        titleView.text = Constants.title
        titleView.numberOfLines = 0
        titleView.textAlignment = .center
        return titleView
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        self.view.addSubview(slider)
        slider.minimumValue = 0
        slider.maximumValue = Float(centerX + Constants.Padding.slide)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)

        return slider
    }()
    
    private lazy var backgroundView: UIImageView = {
        let backgroundView = UIImageView(image: Constants.backgroundImage!)
        self.view.addSubview(backgroundView)
        backgroundView.tintColor = .red
        backgroundView.frame.size = .init(
            width: Constants.Size.side,
            height: Constants.Size.side
        )
        return backgroundView
    }()
    
    private lazy var slideView: UIImageView = {
       let slideView = UIImageView(image: Constants.slideImage!)
        self.view.addSubview(slideView)
        slideView.tintColor = .green
        slideView.frame.size = .init(
                width: Constants.Size.side,
                height: Constants.Size.side
        )
        return slideView
    }()
    
    private var centerY: CGFloat {
        view.frame.maxY / 2
    }
    
    private var centerX: CGFloat {
        view.frame.maxX / 2
    }
    
    private var slideViewMinX: CGFloat {
        view.frame.minX + Constants.Padding.slide
    }
 
    @objc
    private func sliderValueChanged() {
        slideView.center.y = centerY - Constants.Padding.element + CGFloat(slider.value)

        checker()
    }
}

extension ScreenViewController_7 {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapMeButton.isHidden = true
        titleView.center.y = Constants.Padding.element
        titleView.frame.size = .init(width: view.frame.width, height: Constants.Size.title)

        slider.center.y = centerY
        slider.center.x = centerX

        backgroundView.center.y = centerY - Constants.Padding.element
        backgroundView.center.x = centerX

        slideView.center.y = centerY - Constants.Padding.element
        slideView.center.x = slideViewMinX
    }
    
    private func checker() {
        guard slider.value == Float(centerX - Constants.Padding.slide) else { return }
        
        guard backgroundView.center.y == slideView.center.y && backgroundView.center.x == slideView.center.x else { return }
        
        slider.isHidden = true
        tapMeButton.isHidden = false
    }
}

private enum Constants {
    enum Padding {
        static let element: CGFloat = 100
        static let slide: CGFloat = 30
    }
    
    enum Size {
        static let side: CGFloat = 50
        static let title: CGFloat = 50
    }

    static let backgroundImage = UIImage(systemName: "trash.fill")
    static let slideImage = UIImage(systemName: "trash")
    static let title = "Подтвердите, что вы не робот\nСопоставьте изображения"
}
