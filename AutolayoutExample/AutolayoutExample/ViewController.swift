//
//  ViewController.swift
//  AutolayoutExample
//
//  Created by Morgan Kang on 2021/12/04.
//

import UIKit

class ViewController: UIViewController {
    
    var randomColorLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "랜덤 색상"
        label.backgroundColor = .systemPink
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    var greenView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    var colorChange: UIButton = {
        let button: UIButton = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("색상 변경", for: .normal)
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupRandomColorLabel()
        setupGreenView()
        setupColorChange()
    }
    
    func guide(vc: UIViewController) -> UILayoutGuide {
        let guide = vc.view.safeAreaLayoutGuide
        return guide
    }
    
    func setupRandomColorLabel() {
        randomColorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(randomColorLabel)
        
        NSLayoutConstraint.activate([
            randomColorLabel.topAnchor.constraint(equalTo: guide(vc: self).topAnchor, constant: 24),
            randomColorLabel.leadingAnchor.constraint(equalTo: guide(vc: self).leadingAnchor, constant: 24),
            randomColorLabel.trailingAnchor.constraint(equalTo: guide(vc: self).trailingAnchor, constant: -24),
            randomColorLabel.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
    func setupGreenView() {
        greenView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(greenView)
        
        NSLayoutConstraint.activate([
            greenView.topAnchor.constraint(equalTo: randomColorLabel.bottomAnchor, constant: 20),
            greenView.leadingAnchor.constraint(equalTo: guide(vc: self).leadingAnchor, constant: 20),
            greenView.trailingAnchor.constraint(equalTo: guide(vc: self).trailingAnchor, constant: -20),
            greenView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    func setupColorChange() {
        colorChange.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(colorChange)
        
        NSLayoutConstraint.activate([
            colorChange.topAnchor.constraint(equalTo: greenView.bottomAnchor, constant: 24),
            colorChange.centerXAnchor.constraint(equalTo: greenView.centerXAnchor),
//            colorChange.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        colorChange.addTarget(self, action: #selector(didTapColorChange), for: .touchUpInside)
    }
    
    @objc func didTapColorChange() {
        greenView.backgroundColor = .blue
        print("did tap color change button.")
    }
    
}

