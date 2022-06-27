//
//  ConditionDetailStackView.swift
//  FC_CreditCardList
//
//  Created by Morgan Kang on 2022/02/08.
//

import UIKit

class ConditionDetailStackView: UIStackView {
    let conditionDetailTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "참여조건"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    let conditionDetailLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "조건 없음"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
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
        configureConditionDetailTitleLabel()
    }
    
    private func configureConditionDetailTitleLabel() {
        conditionDetailTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionDetailTitleLabel.setContentHuggingPriority(.init(rawValue: 1000), for: .horizontal)
    }
    

}
