//
//  ViewController.swift
//  ViewControllerLifeCycleExample
//
//  Created by Morgan Kang on 2021/12/19.
//

import UIKit

class ViewController: UIViewController {
    
    let nextButton: UIButton = {
        var button: UIButton = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupNextButton()
        
        print("ViewController View가 Load 되었다.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewControlller View가 나타날 것이다.")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewControlller View가 나타났다.")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewControlller View가 사라질 것이다.")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewControlller View가 사라졌다.")
    }
    
    private func setupNextButton() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(nextButton)
        
        let guide = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 150),
        ])
        
        nextButton.addTarget(self, action: #selector(didtapNextButton), for: .touchUpInside)
    }
    
    @objc private func didtapNextButton() {
        let secondVC = SecondViewController()
        secondVC.modalPresentationStyle = .fullScreen
        present(secondVC, animated: true, completion: nil)
    }


}

