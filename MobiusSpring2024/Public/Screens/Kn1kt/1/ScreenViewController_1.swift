//
//  ScreenViewController_1.swift
//  MobiusSpring2024
//

import UIKit

final class ScreenViewController_1: UIViewController {
    let action: () -> Void
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.contentInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        return scrollView
    }()
    
    private lazy var text: UILabel = {
        let label = UILabel()
        label.text = """
        Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

        The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
        """
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var confirmation: UILabel = {
        let label = UILabel()
        label.text = "Подтвердить"
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .tintColor
        label.layer.cornerRadius = 16
        label.layer.cornerCurve = .continuous
        label.layer.masksToBounds = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapConfirmation)))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init(action: @escaping () -> Void) {
        self.action = action
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.addSubview(scrollView)
        scrollView.addSubview(text)
        scrollView.addSubview(confirmation)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            text.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            text.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            text.topAnchor.constraint(equalTo: scrollView.topAnchor),
            text.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            
            confirmation.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            confirmation.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            confirmation.topAnchor.constraint(equalToSystemSpacingBelow: text.bottomAnchor, multiplier: 4.0),
            confirmation.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            confirmation.heightAnchor.constraint(equalToConstant: 44),
            confirmation.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
        ])
        
        setContentScrollView(scrollView)
    }
    
    @objc
    private func onTapConfirmation() {
        action()
    }
}
