//
//  SecondViewController.swift
//  DataPassingExample
//
//  Created by Morgan Kang on 2021/12/20.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func sendData(name: String)
}

class SecondViewController: UIViewController {
    var name: String?
    
    // protocol type의 변수
    weak var delegate: SendDataDelegate?
    
    let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    let popButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Pop", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        if let name = name {
            nameLabel.text = name
        } else {
            nameLabel.text = "nil"
        }
        
        setupNameLabel()
        setupPopButton()
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
    
    func setupPopButton() {
        let guide = self.view.safeAreaLayoutGuide
        
        popButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(popButton)
        
        NSLayoutConstraint.activate([
            popButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            popButton.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -50),
            popButton.widthAnchor.constraint(equalToConstant: 150),
            popButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        popButton.addTarget(self, action: #selector(tappedPopButton), for: .touchUpInside)
    }
    
    @objc private func tappedPopButton() {
        self.delegate?.sendData(name: "from second vc")
        self.navigationController?.popViewController(animated: true)
    }
}
