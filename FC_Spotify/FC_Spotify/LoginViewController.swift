//
//  LoginViewController.swift
//  FC_Spotify
//
//  Created by Morgan Kang on 2022/01/30.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import Firebase
import AuthenticationServices
import CryptoKit

class LoginViewController: UIViewController {
    
    let mainViewController = MainViewController()
    
    let enterEmailVC = EnterEmailViewController()
    
    let mainStackView: MainStackView = {
        let stackView: MainStackView = MainStackView(frame: .zero)
        
        [stackView.mainImageView,
         stackView.mainLabel
        ].forEach { views in
            stackView.addArrangedSubview(views)
        }
//        stackView.backgroundColor = .black
        return stackView
    }()
    
    let buttonsStackView: ButtonsStackView = {
        let stackView: ButtonsStackView = ButtonsStackView(frame: .zero)
        
        [stackView.emailLoginButton,
         stackView.googleLoginButton,
         stackView.AppleLoginButton,
        ].forEach { views in
            stackView.addArrangedSubview(views)
        }
        
        return stackView
    }()
    
    fileprivate var currentNonce: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black
        
        configureButtons()
        setupMainStackView()
        setupButtonsStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        
    }
    
    private func setupMainStackView() {
        let guide = self.view.safeAreaLayoutGuide
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mainStackView)
        
        let constants = (UIScreen.main.bounds.height / 2) * 1/5
        
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
//            mainStackView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: guide.centerYAnchor, constant: -constants)
        ])
        
    }
    
    private func setupButtonsStackView() {
        let guide = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(buttonsStackView)
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 60),
            buttonsStackView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30),
            buttonsStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30),
        ])
    }
    
    private func configureButtons() {
        [buttonsStackView.emailLoginButton,
         buttonsStackView.googleLoginButton,
         buttonsStackView.AppleLoginButton].forEach { buttons in
            buttons.layer.borderWidth = 1
            buttons.layer.borderColor = UIColor.white.cgColor
            buttons.layer.cornerRadius = 30
        }
        buttonsStackView.emailLoginButton.addTarget(self, action: #selector(emailButtonTapped(_:)), for:.touchUpInside)
        buttonsStackView.googleLoginButton.addTarget(self, action: #selector(googleButtonTapped(_:)), for: .touchUpInside)
        buttonsStackView.AppleLoginButton.addTarget(self, action: #selector(appleButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func emailButtonTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(enterEmailVC, animated: true)
    }
    
    
    @objc func googleButtonTapped(_ sender: UIButton) {
        // Firebase ??????
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [weak self] user, error in
            if let error = error {
                debugPrint("ERROR", error.localizedDescription)
                return
            }
            
            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else { return }
            
            // ????????? access token??? id token??? ???????????? ?????? credential????????????.
                // ????????? ?????? ????????? ?????????.
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            // ????????? ?????? ????????? ????????? ???(????????? ??????) ????????? firebase ?????? ????????? ???????????? ????????? signIn ???????????? ????????????.
                // ??? signIn ??????????????? with ????????????????????? ????????? idToken??? accessToken??? ???????????? ?????? ???????????? ???????????? ?????????.
                    // c.f _ ?????? signIn ????????? ????????? email??? password??? ???????????????.
            Auth.auth().signIn(with: credential) { _, _ in
                self?.showMainViewController()
            }
        }
        debugPrint("did tap google button.")
    }
    
    private func showMainViewController() {
        self.navigationController?.pushViewController(mainViewController, animated: true)
    }

    
    @objc func appleButtonTapped(_ sender: UIButton) {
        // apple ????????? ????????? ????????? ??? ?????? ????????? ????????? ?????? ?????? ????????? ???????????? ??? ?????????.
        self.startSignInWithAppleFlow()
        debugPrint("did tap apple button.")
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was recived, but no longer request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Error Apple sign in: %@", error)
                    return
                }
                // User is signed in to Firebase with apple.
                // ...
                /// Main ???????????? ?????????
                self.showMainViewController()
            }
        }
    }
}
// ??? ????????? ????????? ???????????? nonce??? ???????????? ????????????.
extension LoginViewController {
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        // ????????? ???????????? ????????? ??? ????????? request??? ???????????? ??????.
            // ??? request??? nonce??? ???????????? ????????? ????????? ????????????, ?????? firebase????????? ????????? ????????? ??? ??? ?????? ??????.
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // firebase ?????? ????????? ??????(nonce)??? ???????????? ?????? ???????????? ??????
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap { data in
            return String(format: "%02x", data)
        }.joined()
        return hashString
    }
    
    // firebase ?????? ????????? ??????(nonce)??? ???????????? ?????? ???????????? ??????
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0..<16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
