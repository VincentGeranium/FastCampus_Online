//
//  SecondStackView.swift
//  FC_Calculator
//
//  Created by Morgan Kang on 2021/12/31.
//

import UIKit

class SecondStackView: UIStackView {
//    let vc = ViewController()
    
    let sevenButton: CustomButton = {
        let button: CustomButton = CustomButton()
        button.setTitle("7", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        button.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        return button
    }()
    
    let eightButton: CustomButton = {
        let button: CustomButton = CustomButton()
        button.setTitle("8", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        button.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        return button
    }()
    
    let nineButton: CustomButton = {
        let button: CustomButton = CustomButton()
        button.setTitle("9", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        button.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        return button
    }()
    
    let timesButton: CustomButton = {
        let button: CustomButton = CustomButton()
        button.setTitle("×", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        button.backgroundColor = UIColor(red: 254/255, green: 160/255, blue: 10/255, alpha: 1)
        return button
    }()
    
    convenience init(view: UIView) {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .equalSpacing
        self.spacing = 5
        
//        didTapSevenButton()
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupSevenButtonUI()
        setupEightButtonUI()
        setupNineButtonUI()
        setupTimesButtonUI()
    }
    
    private func setupSevenButtonUI() {
        self.sevenButton.isRound = true
    }
    
    private func setupEightButtonUI() {
        self.eightButton.isRound = true
    }
    
    private func setupNineButtonUI() {
        self.nineButton.isRound = true
    }
    
    private func setupTimesButtonUI() {
        self.timesButton.isRound = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func didTapSevenButton() {
//        self.sevenButton.addTarget(vc, action: #selector(vc.tapNumberButton(_:)), for: .touchUpInside)
//    }
    
    
}
