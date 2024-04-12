//
//  ScreenViewController_4.swift
//  MobiusSpring2024
//

import UIKit
import Combine


final class ScreenViewController_4: UIViewController {
    private let button = UIButton()
    private var subs = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setTitle("<<< Calculate >>>", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(startCalculation), for: .touchUpInside)
        view.addSubview(button)
        button.frame = CGRect(x: 100, y: 100, width: 300, height: 50)
    }
    
    @objc
    private func startCalculation() {
        guard subs.isEmpty else { return }
        Just(Actions.Level4.getCalculationData())
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .map(getFibonachi(_:))
            .timeout(.seconds(3), scheduler: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                self.showAlert("Timeout")
                self.subs.removeAll()
            }, receiveValue: {
                if !Actions.Level4.check(result: $0) {
                    self.showAlert("Wrong answer")
                }
            })
            .store(in: &subs)
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    private func getFibonachi(_ n: Int) -> UInt64 {
        guard n > 1 else {
            return UInt64(n)
        }
        
        return getFibonachi(n - 1) + getFibonachi(n - 2)
//        fast solution
//        var cache: [Int] = [0, 1]
//        var i = 0
//        while i < n - 2 {
//            cache.append(cache[i] + cache[i + 1])
//            i+=1
//        }
//        if n == 0 { return 0 }
//        if n == 1 || n == 2 { return 1 }
//        return UInt64(cache[i] + cache[i+1])
    }

}
