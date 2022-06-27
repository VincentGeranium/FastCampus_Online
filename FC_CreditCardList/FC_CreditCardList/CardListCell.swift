//
//  CardListCell.swift
//  FC_CreditCardList
//
//  Created by Morgan Kang on 2022/02/07.
//

import UIKit

class CardListCell: UITableViewCell {
    static let reuseIdentifier: String = "CardListCell"
    
    let cardListStackView: CardListStackView = {
        let stackView: CardListStackView = CardListStackView(frame: .zero)
        
        [stackView.cardImageView,
         stackView.cardNameLabelStackView,
         stackView.chevronImageView
        ].forEach { views in
            stackView.addArrangedSubview(views)
        }
        
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupCardListStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupCardListStackView() {
        cardListStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = self.safeAreaLayoutGuide
        
        self.addSubview(cardListStackView)
        
        NSLayoutConstraint.activate([
            cardListStackView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            cardListStackView.topAnchor.constraint(equalTo: guide.topAnchor),
            cardListStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            cardListStackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            cardListStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10),
        ])
    }
    

    

}
