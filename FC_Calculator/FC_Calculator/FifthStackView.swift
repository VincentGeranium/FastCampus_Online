//
//  FifthStackView.swift
//  FC_Calculator
//
//  Created by Morgan Kang on 2021/12/31.
//

import UIKit

class FifthStackView: UIStackView {
    
    let zeroButton: CustomButton = {
        let button: CustomButton = CustomButton()
        button.setTitle("0", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        return button
    }()
    
    let dotButton: CustomButton = {
        let button: CustomButton = CustomButton()
        button.setTitle(".", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        return button
    }()
    
    let resultButton: CustomButton = {
        let button: CustomButton = CustomButton()
        button.setTitle("=", for: .normal)
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
        setupZeroButtonUI()
        setupDotButtonUI()
        setupResultButtonUI()
    }
    
    private func setupZeroButtonUI() {
        self.zeroButton.isRound = true
    }
    
    private func setupDotButtonUI() {
        self.dotButton.isRound = true
    }
    
    private func setupResultButtonUI() {
        self.resultButton.isRound = true
    }
    
}
