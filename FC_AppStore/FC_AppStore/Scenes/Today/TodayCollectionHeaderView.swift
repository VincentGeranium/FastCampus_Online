//
//  TodayCollectionHeaderView.swift
//  FC_AppStore
//
//  Created by Morgan Kang on 2022/03/07.
//

import UIKit
import SnapKit

final class TodayCollectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier: String = "TodayCollectionHeaderView"
    
    private lazy var dateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "3월 7일 월요일"
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "투데이"
        label.font = .systemFont(ofSize: 36.0, weight: .black)
        label.textColor = .label
        
        return label
    }()
    
    func setupViews() {
        [dateLabel, titleLabel].forEach { self.addSubview($0) }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(32)
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(dateLabel)
            $0.top.equalTo(dateLabel.snp.bottom).offset(8.0)
        }
    }
}
