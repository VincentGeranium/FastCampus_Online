//
//  ContentCollectionViewRankCell.swift
//  FC_Netflix
//
//  Created by Morgan Kang on 2022/02/19.
//

import Foundation
import UIKit
import SnapKit

class ContentCollectionViewRankCell: UICollectionViewCell {
    static let reuseIdentifire: String = "ContentCollectionViewRankCell"
    
    let imageView: UIImageView = UIImageView()
    let rankLabel: UILabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // contentView
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        // imageView
        imageView.contentMode = .scaleToFill
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        // rankLabel
        rankLabel.font = .systemFont(ofSize: 100, weight: .black)
        rankLabel.textColor = .white
        contentView.addSubview(rankLabel)
        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(25)
        }
    }
}
