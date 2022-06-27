//
//  CardNameLabelStackView.swift
//  FC_CreditCardList
//
//  Created by Morgan Kang on 2022/02/07.
//

import UIKit

class CardNameLabelStackView: UIStackView {
    
    let cardNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "신용카드"
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    let rankAndPromotionStackView: RankAndPromotionStackView = {
        let stackView: RankAndPromotionStackView = RankAndPromotionStackView(frame: .zero)
        [stackView.rankLabel,
         stackView.promotionLabel
        ].forEach { views in
            stackView.addArrangedSubview(views)
        }
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .vertical
        self.alignment = .leading
        self.distribution = .fillEqually
        self.spacing = 0
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }

}
