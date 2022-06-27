//
//  RankAndPromotionStackView.swift
//  FC_CreditCardList
//
//  Created by Morgan Kang on 2022/02/07.
//

import UIKit

class RankAndPromotionStackView: UIStackView {
    
    let rankLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "0위"
        label.textColor = .darkGray
        return label
    }()
    
    let promotionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "0만원 증정"
        label.backgroundColor = .lightGray
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.alignment = .center
        self.distribution = .fillProportionally
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        setupPromotionLabel()
    }
    
    private func setupPromotionLabel() {
        promotionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            promotionLabel.widthAnchor.constraint(equalToConstant: 80),
            promotionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    

}
