//
//  EmailAndPasswordStackView.swift
//  FC_Spotify
//
//  Created by Morgan Kang on 2022/02/02.
//

import UIKit

class EmailAndPasswordStackView: UIStackView {
    
    let emailLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "이메일 주소가 무엇인가요?"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.keyboardType = .emailAddress
        textField.backgroundColor = .white
        textField.textColor = .black
        return textField
    }()
    
    let passwordLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "비밀번호를 입력해주세요."
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        textField.textColor = .black
        return textField
    }()
    
    let errorMessageLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .systemRed
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .equalSpacing
        self.spacing = 20
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        setupEmailLabel()
        setupEmailTextField()
        setupPasswordLabel()
        setupPasswordTextField()
        setupErrorMessageLaebel()
    }
    
    private func setupEmailLabel() {
        self.emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailLabel)
    }
    
    private func setupPasswordLabel() {
        self.passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordLabel)
    }
    
    private func setupErrorMessageLaebel() {
        self.errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(errorMessageLabel)
    }
    
    private func setupEmailTextField() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(emailTextField)
        
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupPasswordTextField() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
