//
//  BenefitDateStackView.swift
//  FC_CreditCardList
//
//  Created by Morgan Kang on 2022/02/08.
//

import UIKit

class BenefitDateStackView: UIStackView {
    let benefitDateTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "받는 날짜"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    let benefitDateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "2021.1.1(월)"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .horizontal
        self.alignment = .center
        self.distribution = .fill
        self.spacing = 30
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        configureBenefitDateTitleLabel()
    }
    
    private func configureBenefitDateTitleLabel() {
        benefitDateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        benefitDateTitleLabel.setContentHuggingPriority(.init(rawValue: 1000), for: .horizontal)
    }

}
