//
//  LabelAndTextFieldStackView.swift
//  LEDBoard
//
//  Created by Morgan Kang on 2021/12/22.
//

import UIKit

class LabelAndTextFieldStackView: UIStackView {
    
    let ledTitleLabel: CustomLabel = {
        let label: CustomLabel = CustomLabel(title: "전광판에 표시할 글자.",
                                             textColor: .black,
                                             backgroundColor: .systemBackground)
        return label
    }()
    
    let inputTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "전광판에 표시할 글자."
        textField.backgroundColor = .systemBackground
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.spacing = 13
        self.distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        setupInputTextField()
    }
    
    private func setupInputTextField() {
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.layer.masksToBounds = true
        inputTextField.layer.cornerRadius = 3
        inputTextField.layer.borderColor = UIColor.placeholderText.cgColor
        inputTextField.layer.borderWidth = 0.5
    }
}
