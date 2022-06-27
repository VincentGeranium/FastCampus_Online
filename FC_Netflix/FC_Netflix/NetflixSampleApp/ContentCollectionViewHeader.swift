//
//  ContentCollectionViewHeader.swift
//  FC_Netflix
//
//  Created by Morgan Kang on 2022/02/18.
//

import Foundation
import UIKit
import SnapKit

class ContentCollectionViewHeader: UICollectionReusableView {
    // reuseIdentifier
    static let reuseIdetifier: String = "ContentCollectionViewHeader"
    
    let sectionNameLabel: UILabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // sectionNameLabel 설정
        sectionNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionNameLabel.textColor = .white
        sectionNameLabel.sizeToFit()
        
        // sectionNameLabel를 추가하기
        addSubview(sectionNameLabel)
        
        // sectionNameLabel AutoLayout 잡기.
        sectionNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.leading.bottom.equalToSuperview().offset(10)
        }
    }
}
