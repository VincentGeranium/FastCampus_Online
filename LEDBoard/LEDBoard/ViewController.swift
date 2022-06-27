//
//  ViewController.swift
//  LEDBoard
//
//  Created by Morgan Kang on 2021/12/21.
//

import UIKit

class ViewController: UIViewController, LEDBoardSettingDelegate {
    
    let vc = SettingViewController()
    
    var contentsLabel: UILabel = {
        var label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 50)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vc.delegate = self
        
        contentsLabel.text = "Label"
        contentsLabel.textColor = .yellow
        self.view.backgroundColor = .black
        
        setNavigationBarAppearance()
        setupSettingBarButton()
        setupTitleLabel()
    }
    
    private func setNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
    
    private func setupSettingBarButton() {
        self.navigationController?.navigationBar.topItem?.setRightBarButton(settingBarButtonItem(target: self, action: #selector(tappedSettingBarButton)), animated: true)
    }
    
    @objc private func tappedSettingBarButton() {
        
        vc.ledText = self.contentsLabel.text
        vc.ledTextColor = self.contentsLabel.textColor
        vc.ledBackgroundColor = self.view.backgroundColor ?? .black
        
        self.navigationController?.pushViewController(vc, animated: true)
        print("tapped setting button")
    }
    
    private func setupTitleLabel() {
        let guide = self.view.safeAreaLayoutGuide
        
        contentsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(contentsLabel)
        
        NSLayoutConstraint.activate([
            contentsLabel.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            contentsLabel.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
        ])
    }
    
    func sendData(ledText: String?, ledTextColor: UIColor, ledBackgroundColor: UIColor) {
        if let ledText = ledText {
            self.contentsLabel.text = ledText
            print("😀 \(ledText)")
        }
        self.contentsLabel.textColor = ledTextColor
        self.view.backgroundColor = ledBackgroundColor
    }
}
