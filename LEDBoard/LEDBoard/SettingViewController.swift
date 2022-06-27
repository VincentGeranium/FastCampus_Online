//
//  SettingViewController.swift
//  LEDBoard
//
//  Created by Morgan Kang on 2021/12/22.
//

import UIKit

protocol LEDBoardSettingDelegate: AnyObject {
    func sendData(ledText: String?, ledTextColor: UIColor, ledBackgroundColor: UIColor)
}

class SettingViewController: UIViewController {
    
    let stackView: LabelAndTextFieldStackView = {
        let stackView: LabelAndTextFieldStackView = LabelAndTextFieldStackView()
        [stackView.ledTitleLabel,
         stackView.inputTextField].forEach { views in
            stackView.addArrangedSubview(views)
        }
        stackView.backgroundColor = .systemBackground
        return stackView
    }()
    
    let textColorChangeStackView: TextColorChangeStackView = {
        let stackView: TextColorChangeStackView = TextColorChangeStackView()
        [stackView.textColorChangeLabel,
         stackView.buttonsStackView].forEach { views in
            stackView.addArrangedSubview(views)
        }
        return stackView
    }()
    
    let backgroundColorChangeStackView: BackgroundColorChangeStackView = {
        let stackView: BackgroundColorChangeStackView = BackgroundColorChangeStackView()
        [stackView.backgroundColorChangeLabel,
         stackView.buttonsStackView].forEach { views in
            stackView.addArrangedSubview(views)
        }
        return stackView
    }()
    
    let saveButton: CustomButton = {
        let button = CustomButton()
        button.setButtonTitle(title: "저장")
        button.setButtonTitleColors(color: .systemBlue)
        return button
    }()
    
    weak var delegate: LEDBoardSettingDelegate?
    
    var ledText: String?
    var ledTextColor: UIColor = .yellow
    var ledBackgroundColor: UIColor = .black

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "설정"
        self.view.backgroundColor = .white
        
        setupStackView()
        setupTextColorChangeStackView()
        setupTextColorChangeButtonActions()
        setupBackgroundColorChangeStackView()
        setupBackgroundColorChangeButtonActions()
        setupSaveButton()
        configure()
    }
    
    private func configure() {
        if let ledText = ledText {
            self.stackView.inputTextField.text = ledText
        }
        self.changeTextAlpha(color: self.ledTextColor)
        self.changeBackgroundAlpha(color: self.ledBackgroundColor)
    }
    
    private func setupStackView() {
        let guide = self.view.safeAreaLayoutGuide
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -24),
            stackView.heightAnchor.constraint(equalToConstant: 69.5),
        ])
    }
    
    private func setupTextColorChangeStackView() {
        self.textColorChangeStackView.buttonsStackView.firstButton.alpha = 1
        self.textColorChangeStackView.buttonsStackView.secondButton.alpha = 0.2
        self.textColorChangeStackView.buttonsStackView.thirdButton.alpha = 0.2
        
        let guide = self.view.safeAreaLayoutGuide
        
        textColorChangeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(textColorChangeStackView)
        
        NSLayoutConstraint.activate([
            textColorChangeStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 35),
            textColorChangeStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 24),
            textColorChangeStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -24),
//            textColorChangeStackView.heightAnchor.constraint(equalToConstant: 69.5),
        ])
    }
    
    private func setupBackgroundColorChangeStackView() {
        self.backgroundColorChangeStackView.buttonsStackView.firstButton.alpha = 1
        self.backgroundColorChangeStackView.buttonsStackView.secondButton.alpha = 0.2
        self.backgroundColorChangeStackView.buttonsStackView.thirdButton.alpha = 0.2
        
        let guide = self.view.safeAreaLayoutGuide
        
        backgroundColorChangeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(backgroundColorChangeStackView)
        
        NSLayoutConstraint.activate([
            backgroundColorChangeStackView.topAnchor.constraint(equalTo: textColorChangeStackView.bottomAnchor, constant: 35),
            backgroundColorChangeStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 24),
            backgroundColorChangeStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -24),
        ])
    }
    
    private func setupSaveButton() {
        let guide = self.view.safeAreaLayoutGuide
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: backgroundColorChangeStackView.bottomAnchor, constant: 24),
            saveButton.centerXAnchor.constraint(equalTo: backgroundColorChangeStackView.centerXAnchor),
        ])
        
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    private func setupTextColorChangeButtonActions() {
        textColorChangeStackView.buttonsStackView.firstButton.addTarget(self, action: #selector(changeTextColorButton), for: .touchUpInside)
        textColorChangeStackView.buttonsStackView.secondButton.addTarget(self, action: #selector(changeTextColorButton), for: .touchUpInside)
        textColorChangeStackView.buttonsStackView.thirdButton.addTarget(self, action: #selector(changeTextColorButton), for: .touchUpInside)
    }
    
    @objc private func changeTextColorButton(_ sender: UIButton) {

        if sender == textColorChangeStackView.buttonsStackView.firstButton {
            self.ledTextColor = .yellow
            changeTextAlpha(color: .yellow)
        } else if sender == textColorChangeStackView.buttonsStackView.secondButton {
            self.ledTextColor = .purple
            changeTextAlpha(color: .purple)
        } else {
            self.ledTextColor = .green
            changeTextAlpha(color: .green)
        }
    }
    
    private func changeTextAlpha(color: UIColor) {
        self.textColorChangeStackView.buttonsStackView.firstButton.alpha = color == UIColor.yellow ? 1 : 0.2
        self.textColorChangeStackView.buttonsStackView.secondButton.alpha = color == UIColor.purple ? 1 : 0.2
        self.textColorChangeStackView.buttonsStackView.thirdButton.alpha = color == UIColor.green ? 1 : 0.2
    }
    
    private func setupBackgroundColorChangeButtonActions() {
        backgroundColorChangeStackView.buttonsStackView.firstButton.addTarget(self, action: #selector(changeBackgroundColorButton), for: .touchUpInside)
        backgroundColorChangeStackView.buttonsStackView.secondButton.addTarget(self, action: #selector(changeBackgroundColorButton), for: .touchUpInside)
        backgroundColorChangeStackView.buttonsStackView.thirdButton.addTarget(self, action: #selector(changeBackgroundColorButton), for: .touchUpInside)
    }
    
    @objc private func changeBackgroundColorButton(_ sender: UIButton) {
        let blackButton = backgroundColorChangeStackView.buttonsStackView.firstButton
        let blueButton = backgroundColorChangeStackView.buttonsStackView.secondButton
        let orangeButton = backgroundColorChangeStackView.buttonsStackView.thirdButton
        
        if sender == blackButton {
            self.ledBackgroundColor = .black
            changeBackgroundAlpha(color: .black)
        } else if sender == blueButton {
            self.ledBackgroundColor = .blue
            changeBackgroundAlpha(color: .blue)
        } else {
            self.ledBackgroundColor = .orange
            changeBackgroundAlpha(color: .orange)
        }
    }
    
    private func changeBackgroundAlpha(color: UIColor) {
        self.backgroundColorChangeStackView.buttonsStackView.firstButton.alpha = color == UIColor.black ? 1 : 0.2
        self.backgroundColorChangeStackView.buttonsStackView.secondButton.alpha = color == UIColor.blue ? 1 : 0.2
        self.backgroundColorChangeStackView.buttonsStackView.thirdButton.alpha = color == UIColor.orange ? 1 : 0.2
    }
    
    @objc private func didTapSaveButton() {
        
        self.delegate?.sendData(
            ledText: self.stackView.inputTextField.text,
            ledTextColor: self.ledTextColor,
            ledBackgroundColor: self.ledBackgroundColor
        )
        
        print(self.stackView.inputTextField.text)
        print(self.ledTextColor)
        print(self.ledBackgroundColor)
        
        self.navigationController?.popViewController(animated: true)
    }
}
