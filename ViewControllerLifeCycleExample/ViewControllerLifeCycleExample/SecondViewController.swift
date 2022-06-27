//
//  SecondViewController.swift
//  ViewControllerLifeCycleExample
//
//  Created by Morgan Kang on 2021/12/19.
//

import UIKit

class SecondViewController: UIViewController {
    
    let backButton: UIButton = {
        var button: UIButton = UIButton()
        button.setTitle("BACK", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupBackButton()
        
        print("SecondViewController View가 Load 되었다.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SecondViewControlller View가 나타날 것이다.")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("SecondViewControlller View가 나타났다.")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("SecondViewControlller View가 사라질 것이다.")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("SecondViewControlller View가 사라졌다.")
    }
    
    private func setupBackButton() {
        let guide = self.view.safeAreaLayoutGuide
        
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            backButton.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 150),
        ])
        
        self.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    @objc private func didTapBackButton() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
