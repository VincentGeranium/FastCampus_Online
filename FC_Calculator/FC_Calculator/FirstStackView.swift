//
//  FirstStackView.swift
//  FC_Calculator
//
//  Created by Morgan Kang on 2021/12/31.
//

import UIKit

class FirstStackView: UIStackView {
    
    let acButton: CustomButton = {
        let button: CustomButton = CustomButton()
        button.isRound = true
        button.setTitle("AC", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        button.backgroundColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1)
        return button
    }()
    
    let divideButton: CustomButton = {
        let button: CustomButton = CustomButton()
        button.setTitle("÷", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        button.backgroundColor = UIColor(red: 254/255, green: 160/255, blue: 10/255, alpha: 1)
        return button
    }()
    
    convenience init() {
        self.init(frame: .zero)
     
    }
    
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
        setupACButtonUI()
        setupDivideButtonUI()
        
    }
    
    private func setupACButtonUI() {
        self.acButton.isRound = true
    }
    
    private func setupDivideButtonUI() {
        self.divideButton.isRound = true
    }

}
