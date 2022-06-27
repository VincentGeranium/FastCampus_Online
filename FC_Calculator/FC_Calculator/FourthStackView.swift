//
//  FourthStackView.swift
//  FC_Calculator
//
//  Created by Morgan Kang on 2021/12/31.
//

import UIKit

class FourthStackView: UIStackView {
    
    let oneButton: CustomButton = {
        let button: CustomButton = CustomButton()
        button.setTitle("1", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        return button
    }()
    
    let twoButton: CustomButton = {
        let button: CustomButton = CustomButton()
        button.setTitle("2", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        return button
    }()
    
    let threeButton: CustomButton = {
        let button: CustomButton = CustomButton()
        button.setTitle("3", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        return button
    }()
    
    let plusButton: CustomButton = {
        let button: CustomButton = CustomButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 254/255, green: 160/255, blue: 10/255, alpha: 1)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .equalSpacing
        self.spacing = 5
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupOneButtonUI()
        setupTwoButtonUI()
        setupThreeButtonUI()
        setupPlusButtonUI()
    }
    
    private func setupOneButtonUI() {
        self.oneButton.isRound = true
    }
    
    private func setupTwoButtonUI() {
        self.twoButton.isRound = true
    }
    
    private func setupThreeButtonUI() {
        self.threeButton.isRound = true
    }
    
    private func setupPlusButtonUI() {
        self.plusButton.isRound = true
    }
    
}
