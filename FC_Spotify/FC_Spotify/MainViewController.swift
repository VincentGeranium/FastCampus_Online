//
//  MainViewController.swift
//  FC_Spotify
//
//  Created by Morgan Kang on 2022/02/03.
//

import Foundation
import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    
    let welcomeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "환영합니다."
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let resetPasswordButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("비밀번호 변경", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(resetPasswordButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let profileUpdateButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("프로필 업데이트", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(profileUpdateButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let logoutButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.addTarget(self, action: #selector(logoutButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Main VC view did load")
        
        self.view.backgroundColor = .black
        
        //pop gesture를 막을 수 있는 코드
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        setupWelcomeLabel()
        setupResetPasswordButton()
        setupProfileUpdateButton()
        setupLogoutButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // navigation bar 숨기기 코드
        navigationController?.navigationBar.isHidden = true
        
        // 로그인 했을 경우 firebase를 통하여 로그인한 사용자의 email을 가져올 수 있다.
        let email = Auth.auth().currentUser?.email ?? "고객"
        debugPrint(email)
        
        // label 의 유동적 변경을 통한 email의 성공과 실패 여부를 알 수 있다.
            // 성공시 환영합니다 유저의 이메일 님 이라고 나옴.
            // 실패시 환영합니다 고객 님 이라고 나옴.
        welcomeLabel.text = """
        환영합니다.
        \(email) 님.
        """
        // Auth.auth().currentUser?.providerData[0].providerID의 경로갔을 경우 값이 "password"일 경우 이메일/비밀번호로 로그인 한 것이다.
            // 즉, 소셜 로그인인 APPLE, Google 로그인을 사용한것이 아니라는 말이다.
        let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
        // 이메일/비밀번호로 로그인한 유저의 경우 resetPasswordButton이 보여져야하므로 아래와 같은 코드가 작성되어야 한다.
        resetPasswordButton.isHidden = !isEmailSignIn
        
    }
    
    private func setupWelcomeLabel() {
        let guide = self.view.safeAreaLayoutGuide
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(welcomeLabel)
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
        ])
    }
    
    private func setupResetPasswordButton() {
        let guide = self.view.safeAreaLayoutGuide
        
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(resetPasswordButton)
        
        NSLayoutConstraint.activate([
            resetPasswordButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            resetPasswordButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
//            resetPasswordButton.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -20),
        ])
    }
    
    private func setupProfileUpdateButton() {
        let guide = self.view.safeAreaLayoutGuide
        
        profileUpdateButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(profileUpdateButton)
        
        NSLayoutConstraint.activate([
            profileUpdateButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            profileUpdateButton.topAnchor.constraint(equalTo: resetPasswordButton.bottomAnchor, constant: 20),
        ])
    }
    
    private func setupLogoutButton() {
        let guide = self.view.safeAreaLayoutGuide
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: profileUpdateButton.bottomAnchor, constant: 20),
            logoutButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
        ])
    }
    
    @objc func logoutButtonTapped(_ sender: UIButton) {
        // sign out 함수는 error 처리를 위한 throw 함수이므로, do - try - catch 문을 이용하여 처리한다.
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            // signOut이 성공적으로 이루어졌을 경우 popToRootViewController code 실행.
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            debugPrint("ERROR : sign out error !! \(signOutError)")
        }
    }
    
    @objc func resetPasswordButtonTapped(_ sender: UIButton) {
        // 실제로 이메일에 비밀번호를 변경할 수 있는 이메일을 보내주는 요소를 만들어준다.
        let email = Auth.auth().currentUser?.email ?? ""
        
        // sendPasswordReset 메서드를 이용하여 비밀번호 변경에 관한 작업을 한다.
            // 파라미터로는 유저의 이메일을 받으며 실제 유저의 이메일로 비밀번호 변경에 관한 메일이 보내지게 된다.
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
    }
    
    @objc func profileUpdateButtonTapped(_ sender: UIButton) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = "유저"
        changeRequest?.commitChanges(completion: { _ in
            let displayName = Auth.auth().currentUser?.displayName ?? Auth.auth().currentUser?.email ?? "nil"
            
            self.welcomeLabel.text = """
            환영합니다.
            \(displayName)님
            """
        })
    }
}
