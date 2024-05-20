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
        Нажимая кнопку подтвердить - я подтверждаю:
        
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sed laoreet dui. In lobortis a lacus euismod ultricies. In suscipit, nunc ac imperdiet cursus, elit nisi pretium dolor, nec tempor velit eros non sem. Integer varius, justo dictum fringilla accumsan, nulla ipsum placerat erat, quis sodales purus metus tristique nisl. Phasellus imperdiet consequat nibh eget eleifend. Vivamus posuere ultricies accumsan. Fusce eget augue sit amet nunc lobortis elementum. Vestibulum et commodo nunc. Morbi a odio id sem maximus ullamcorper. Sed ultrices felis a turpis varius, ut vehicula velit elementum. Duis at sapien in orci tempus tempor sit amet ac velit. Nam vehicula ullamcorper libero sed porttitor. Vivamus blandit massa nec purus molestie, eget tempus nisl iaculis. Proin malesuada vestibulum neque, vel scelerisque nibh posuere et. Ut risus felis, dapibus ut ligula ac, cursus varius sapien. Nam non orci justo.

        Mauris maximus aliquam enim non molestie. Quisque et mauris quis tellus porta bibendum at et dui. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Suspendisse ornare euismod leo vel fringilla. Morbi et dictum tellus. Suspendisse potenti. Duis sit amet egestas ligula. Nam imperdiet finibus est a sodales. Proin eu metus interdum, fringilla nibh ut, laoreet libero. Aliquam vestibulum est nec eros sagittis posuere. Suspendisse semper sodales viverra. Morbi in neque eu metus ultrices sollicitudin eget at felis. Aliquam faucibus vestibulum odio quis rutrum.

        Quisque vulputate sem quis sapien congue, eu tincidunt elit consectetur. Sed pretium turpis mi, quis gravida ipsum molestie in. Praesent placerat convallis blandit. Duis eget dui ante. Donec sollicitudin elementum nibh, eu finibus nibh cursus id. Nulla auctor in arcu vel fringilla. Aenean porta at est fermentum viverra. Aliquam ut est dapibus, sollicitudin tellus cursus, vulputate nisl.

        Vivamus malesuada aliquam libero, aliquet accumsan enim tristique vel. Mauris viverra id sem vel posuere. Duis metus arcu, imperdiet vel turpis vitae, maximus lacinia sapien. Suspendisse sed ipsum a ipsum viverra luctus quis ac dui. Aliquam erat volutpat. Cras tempor vel risus ac pulvinar. Praesent blandit vitae risus eget mollis. Maecenas semper urna vitae dignissim tincidunt. Vivamus faucibus eros vitae purus interdum tempus. Cras consequat vitae orci quis posuere. Donec commodo accumsan justo et venenatis. Maecenas vel quam dui. Morbi at purus eu mauris pulvinar venenatis in sit amet lectus. Suspendisse porta posuere rhoncus.

        Mauris pellentesque lobortis sem, vestibulum aliquam elit sagittis at. Ut placerat suscipit neque sit amet scelerisque. Aliquam fermentum lorem eget leo euismod sodales. Nullam pharetra, quam quis malesuada venenatis, orci lectus vestibulum massa, quis laoreet leo nibh sed ex. Duis sed mollis tortor, in accumsan dui. Etiam eget feugiat velit, non lacinia orci. Nam ultrices pellentesque mi ut blandit. Donec congue iaculis nunc, vitae hendrerit libero hendrerit id. In in luctus dui. Donec accumsan, urna sed bibendum consequat, diam velit vulputate massa, eu laoreet nibh enim a ante. Fusce placerat consectetur sodales. Donec aliquam ultrices nisl, quis venenatis eros sollicitudin nec. Suspendisse vitae tortor ac sapien hendrerit tincidunt a sed ante. Fusce feugiat nunc quis euismod fringilla. Cras placerat mauris eget nunc vestibulum, sit amet congue nisl pulvinar.
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
        label.backgroundColor = .tintColor
        label.layer.cornerRadius = 16
        label.layer.cornerCurve = .continuous
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
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
    }
    
    override func contentScrollView(for edge: NSDirectionalRectEdge) -> UIScrollView? {
        scrollView
    }
    
    @objc
    private func onTapConfirmation() {
        action()
    }
}
