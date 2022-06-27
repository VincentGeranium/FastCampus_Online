//
//  EnterEmailViewController.swift
//  FC_Spotify
//
//  Created by Morgan Kang on 2022/02/02.
//

import Foundation
import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {
    let mainViewController = MainViewController()
    
    let emailAndPasswordStackView: EmailAndPasswordStackView = {
        let stackView = EmailAndPasswordStackView(frame: .zero)
        
        [stackView.emailLabel,
         stackView.emailTextField,
         stackView.passwordLabel,
         stackView.passwordTextField,
         stackView.errorMessageLabel,
        ].forEach { views in
            stackView.addArrangedSubview(views)
        }
        
        return stackView
    }()
    
    let nextButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        setupEmailAndPasswordStackView()
        setupNextButton()
        configureNextButton()
        
        // 버튼 초기 설정
        nextButton.isEnabled = false
        
        //MARK: - delegate setup
        emailAndPasswordStackView.emailTextField.delegate = self
        emailAndPasswordStackView.passwordTextField.delegate = self
        
        emailAndPasswordStackView.emailTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "이메일/비밀번호 입력하기."
        setNavigationBarAppearance()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
    }
    
    private func setupEmailAndPasswordStackView() {
        let guide = self.view.safeAreaLayoutGuide
        
        emailAndPasswordStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(emailAndPasswordStackView)
        
        NSLayoutConstraint.activate([
            emailAndPasswordStackView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 70),
            emailAndPasswordStackView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            emailAndPasswordStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30),
            emailAndPasswordStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30),
        ])
    }
    
    private func setupNextButton() {
        let guide = self.view.safeAreaLayoutGuide
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(nextButton)
        
        nextButton.layer.cornerRadius = 30
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: emailAndPasswordStackView.bottomAnchor, constant: 60),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func configureNextButton() {
        self.nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        // Firebase 이메일/비밀번호 인증
        let email = emailAndPasswordStackView.emailTextField.text ?? ""
        debugPrint(email)
        let password = emailAndPasswordStackView.passwordTextField.text ?? ""
        debugPrint(password)
        // Firebase Auth SDK에서 제공하는 'createUser'
            // 이것을 통해 Firebase 인증 플랫폼에 전달을 할 수 있다.
        
        // createUser 메서드의 클로저에서 파라미터 중 AuthDataResult 는 결괏값 받고 Error은 에러에 대한 값을 받는다.
        
        //MARK: - 신규 사용자 생성
            // c.f _ 순환 참조 방지를 위해 [weak self]
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                
                switch code {
                case 17007: // 이미 가입된 유저일 경우
                    // 로그인하기
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.emailAndPasswordStackView.errorMessageLabel.text = error.localizedDescription
                }
            } else {
                // 로그인이 성공적일 경우 메인 뷰 컨트롤러로 present
                self.showMainViewController()
            }
        }
    }
    
    private func showMainViewController() {
        self.navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    // firebase 인증을 통해 로그인을 할 수 있는 signIn closure
    private func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                self.emailAndPasswordStackView.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
}

extension EnterEmailViewController: UITextFieldDelegate {
    // 이메일 비밀번호 입력이 끝난 후 리턴 버튼을 눌렀을 때 키보드가 내려가게 하는 메소드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    // 이메일과 비밀번호 입력값을 확인하여 다음 버튼을 활성화.
    func textFieldDidEndEditing(_ textField: UITextField) {
        // 이메일, 비밀번호 텍스트 값이 있을 때 다음 버튼 활성화.
        let isEmailEmpty = emailAndPasswordStackView.emailTextField.text == ""
        let isPasswordEmpty = emailAndPasswordStackView.passwordTextField.text == ""
        
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
