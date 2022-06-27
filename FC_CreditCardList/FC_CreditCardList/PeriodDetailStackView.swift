//
//  PeriodDetailStackView.swift
//  FC_CreditCardList
//
//  Created by Morgan Kang on 2022/02/08.
//

import UIKit

class PeriodDetailStackView: UIStackView {
    let periodDateTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "참여기간"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    let periodDateDetailLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "2021.1.1(월)~1.31(일)"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
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
        
        configurePeriodDateTitleLabel()
    }
    
    private func configurePeriodDateTitleLabel() {
        periodDateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        periodDateTitleLabel.setContentHuggingPriority(.init(rawValue: 1000), for: .horizontal)
    }
    

}
