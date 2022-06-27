//
//  DiaryCollectionViewCell.swift
//  FC_Diary
//
//  Created by Morgan Kang on 2022/01/10.
//

import UIKit

class DiaryCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier: String = "DiaryCollectionViewCell"
    
    var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.text = "Label"
        return label
    }()
    
    var dateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.text = "21.01.12 (수)"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .white
        
        setupTitleLabel()
        setupDateLabel()
        
        // 셀의 테두리를 그려주는 코드.
        self.contentView.layer.cornerRadius = 3.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    // 이 생성자는 UIView가 xib나 storyboard에서 생성이 될 때, 이 생성자를 통해 객채가 생성이 된다.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    private func setupTitleLabel() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLabel.setContentHuggingPriority(.init(250), for: .vertical)
        self.titleLabel.setContentHuggingPriority(.init(251), for: .horizontal)
        self.titleLabel.setContentCompressionResistancePriority(.init(rawValue: 750), for: .horizontal)
        self.titleLabel.setContentCompressionResistancePriority(.init(750), for: .vertical)
        
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
        ])
    }
    
    private func setupDateLabel() {
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.dateLabel.setContentHuggingPriority(.init(251), for: .vertical)
        self.dateLabel.setContentHuggingPriority(.init(251), for: .horizontal)
        self.dateLabel.setContentCompressionResistancePriority(.init(751), for: .vertical)
        self.dateLabel.setContentCompressionResistancePriority(.init(750), for: .horizontal)
        
        self.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
        ])
    }
    
}
