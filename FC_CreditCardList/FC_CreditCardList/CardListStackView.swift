//
//  CardListStackView.swift
//  FC_CreditCardList
//
//  Created by Morgan Kang on 2022/02/07.
//

import UIKit

class CardListStackView: UIStackView {
    
    let cardImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(systemName: "creditcard.fill")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let cardNameLabelStackView: CardNameLabelStackView = {
        let stackView: CardNameLabelStackView = CardNameLabelStackView(frame: .zero)
        [stackView.rankAndPromotionStackView,
         stackView.cardNameLabel,
        ].forEach { views in
            stackView.addArrangedSubview(views)
        }
        return stackView
    }()
    
    let chevronImageView: UIImageView = {
        let imageView:  UIImageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .horizontal
        self.alignment = .center
        self.distribution = .fill
        self.spacing = 0
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        setupCardImage()
        setupChevronImageView()
    }
    
    private func setupCardImage() {
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardImageView.widthAnchor.constraint(equalToConstant: 80),
            cardImageView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    private func setupChevronImageView() {
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chevronImageView.widthAnchor.constraint(equalToConstant: 20),
            chevronImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    

}
