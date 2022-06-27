//
//  ButtonsStackView.swift
//  FC_Spotify
//
//  Created by Morgan Kang on 2022/02/02.
//

import UIKit
import GoogleSignIn

class ButtonsStackView: UIStackView {
    
    let emailLoginButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("이메일/비밀번호로 계속하기.", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    // GIDSignInButton은 UIButton을 상속하면서 구글 로그인을 실행시켜주는 구글 signIn SDK 객체이다.
    
    var googleLoginButton: UIButton = {
        var button: UIButton = UIButton()
        button.setTitle("구글로 계속하기.", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(named: "logo_google"), for: .normal)
        button.titleEdgeInsets = .init(top: 0, left: -31, bottom: 0, right: 0)
        button.imageEdgeInsets = .init(top: 0, left: -119, bottom: 0, right: 0)
        return button
    }()
    
    let AppleLoginButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Apple로 계속하기.", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(named: "logo_apple"), for: .normal)
        button.titleEdgeInsets = .init(top: 0, left: -31, bottom: 0, right: 0)
        button.imageEdgeInsets = .init(top: 0, left: -100, bottom: 0, right: 0)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.alignment = .center
        self.distribution = .fillEqually
        self.spacing = 15
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        setupEmailButton()
        setupGoogleButton()
        setupAppleButton()
    }
    
    
    private func setupEmailButton() {
        let guide = self.safeAreaLayoutGuide
        
        emailLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(emailLoginButton)
        
        NSLayoutConstraint.activate([
            emailLoginButton.heightAnchor.constraint(equalToConstant: 60),
            emailLoginButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            emailLoginButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
        ])
    }
    
    private func setupGoogleButton() {
        let guide = self.safeAreaLayoutGuide
        
//        guard let googleLoginButton = googleLoginButton as? UIButton else { return }
//
//        googleLoginButton.setTitle("구글로 계속하기.", for: .normal)
//        googleLoginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//        googleLoginButton.setTitleColor(.white, for: .normal)
//        googleLoginButton.setImage(UIImage(named: "logo_google"), for: .normal)
//        googleLoginButton.titleEdgeInsets = .init(top: 0, left: -31, bottom: 0, right: 0)
//        googleLoginButton.imageEdgeInsets = .init(top: 0, left: -119, bottom: 0, right: 0)
        
        googleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(googleLoginButton)
        
        NSLayoutConstraint.activate([
            googleLoginButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            googleLoginButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
        ])
        
    }
    
    private func setupAppleButton() {
        let guide = self.safeAreaLayoutGuide
        
        AppleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(AppleLoginButton)
        
        NSLayoutConstraint.activate([
            AppleLoginButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            AppleLoginButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
        ])
    }

}
