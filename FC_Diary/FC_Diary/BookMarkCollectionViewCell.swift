//
//  BookMarkCollectionViewCell.swift
//  FC_Diary
//
//  Created by Morgan Kang on 2022/01/12.
//

import UIKit

class BookMarkCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier: String = "BookMarkCollectionViewCell"
    
    let bookMarkLabelStackView: BookMarkLabelStackView = {
        let stackView: BookMarkLabelStackView = BookMarkLabelStackView()
        
        [stackView.titleLabel,
         stackView.dateLabel].forEach { views in
            stackView.addArrangedSubview(views)
        }
        
        return stackView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupBookMarkLabelStackView()
        
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 3.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBookMarkLabelStackView() {
        bookMarkLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(bookMarkLabelStackView)
        
        NSLayoutConstraint.activate([
            bookMarkLabelStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            bookMarkLabelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            bookMarkLabelStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        
    }
    
    
}
