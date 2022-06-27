//
//  BeerListCell.swift
//  FC_Brewery
//
//  Created by Morgan Kang on 2022/02/23.
//

import Foundation
import SnapKit
import Kingfisher
import UIKit

class BeerListCell: UITableViewCell {
    static let reuseIdentifier: String = "BeerListCell"
    
    let beerImageView: UIImageView = UIImageView()
    let nameLabel: UILabel = UILabel()
    let taglineLabel: UILabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [beerImageView, nameLabel, taglineLabel].forEach {
            contentView.addSubview($0)
        }
        
        // ImageView
        beerImageView.contentMode = .scaleAspectFit
        
        // nameLabel
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        nameLabel.numberOfLines = 2
        
        // taglineLabel
        taglineLabel.font = .systemFont(ofSize: 14, weight: .light)
        taglineLabel.textColor = .systemBlue
        taglineLabel.numberOfLines = 0
        
        // ImageView AutoLayout
        beerImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(120)
        }
        
        // nameLabel AutoLayout
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(beerImageView.snp.trailing).offset(10)
            $0.bottom.equalTo(beerImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        // taglineLabel AutoLayout
        taglineLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
    }
    
    //MARK: - configure(with:)
    func configure(with beer: Beer) {
        let imageURL = URL(string: beer.imageURL ?? "")
        beerImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "beer_icon"), options: nil, completionHandler: nil)
        nameLabel.text = beer.name ?? "이름 없는 맥주"
        taglineLabel.text = beer.tagLine
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
}
