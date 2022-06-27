//
//  ViewController.swift
//  DataPassingExample
//
//  Created by Morgan Kang on 2021/12/20.
//

import UIKit

class FirstViewController: UIViewController, SendDataDelegate {
    let vc = SecondViewController()
    
    var name: String?
    
    let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    let pushButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("push", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        vc.delegate = self
        
        if let name = name {
            nameLabel.text = name
        } else {
            nameLabel.text = "label"
        }
        
        setupNameLabel()
        setupPushButton()
    }
    
    func setupNameLabel() {
        let guide = self.view.safeAreaLayoutGuide
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 150),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func setupPushButton() {
        let guide = self.view.safeAreaLayoutGuide
        
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(pushButton)
        
        NSLayoutConstraint.activate([
            pushButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            pushButton.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -50),
            pushButton.widthAnchor.constraint(equalToConstant: 300),
            pushButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        pushButton.addTarget(self, action: #selector(tappedPushButton), for: .touchUpInside)
    }
    
    @objc private func tappedPushButton() {
        vc.name = "from firstVC"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func sendData(name: String) {
        self.nameLabel.text = name
        self.nameLabel.sizeToFit()
    }



}

