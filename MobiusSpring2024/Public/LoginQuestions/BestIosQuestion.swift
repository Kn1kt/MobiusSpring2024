//
//  BestIosQuestion.swift
//  MobiusSpring2024
//

import UIKit

final class BestIosQuestionViewController: UIViewController {
    
    private lazy var answerField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Введите ответ"
        field.textAlignment = .center
        return field
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Кто является главным iOS пользователем в мире?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var okButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "OK"
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { [weak self] _ in
            if self?.answerField.text == "Башир" {
                self?.action()
            } else {
                let alert = UIAlertController(
                    title: "Неверно",
                    message: "Вы ввели неправильный ответ",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self?.present(alert, animated: true)
            }
        }), for: .touchUpInside)
        return button
    }()
    
    private var action: () -> Void
    init(action: @escaping () -> Void) {
        self.action = action
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        activateConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        answerField.becomeFirstResponder()
    }
    
    private func setupSubviews() {
        view.addSubview(questionLabel)
        view.addSubview(answerField)
        view.addSubview(okButton)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            answerField.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            answerField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerField.widthAnchor.constraint(equalToConstant: 150),
            okButton.topAnchor.constraint(equalTo: answerField.bottomAnchor, constant: 20),
            okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
