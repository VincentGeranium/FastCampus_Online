//
//  ContentCollectionViewCell.swift
//  FC_Netflix
//
//  Created by Morgan Kang on 2022/02/18.
//

import Foundation
import UIKit
import SnapKit

class ContentCollectionViewCell: UICollectionViewCell {
    // identifire 선언
    static let reuseIdentifire: String = "ContentCollectionViewCell"
    
    // imageView 선언
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // contentView 설정
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        // imageView 설정
        imageView.contentMode = .scaleAspectFill
        
        // imageView를 추가.
        contentView.addSubview(imageView)
        
        // snapKit을 이용한 imageView AutoLayout 설정.
        imageView.snp.makeConstraints { imageView in
            imageView.edges.equalToSuperview()
        }
    }
}
