//
//  TodayCollectionViewCell.swift
//  FC_AppStore
//
//  Created by Morgan Kang on 2022/03/07.
//

import SnapKit
import UIKit
import Kingfisher

final class TodayCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier: String = "TodayCollectionViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font =  .systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font =  .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font =  .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12.0
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    func setup(today: Today) {
        setupSubViews()
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 10
        
        subTitleLabel.text = today.subTitle
        titleLabel.text = today.title
        descriptionLabel.text = today.description
        
        if let imageURL = URL(string: today.imageURL) {
            imageView.kf.setImage(
                with: imageURL,
                placeholder: nil,
                options: nil,
                completionHandler: nil
            )
        }
    }
}

private extension TodayCollectionViewCell {
    func setupSubViews() {
        [
            imageView,
            titleLabel,
            subTitleLabel,
            descriptionLabel,
        ].forEach {
            self.addSubview($0)
        }
        // 강의에서 나온 code
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.0)
            $0.trailing.equalToSuperview().inset(24.0)
            $0.top.equalToSuperview().inset(24.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(subTitleLabel)
            $0.trailing.equalTo(subTitleLabel)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(4)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        /*
        // 내가 짠 layout code
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.bottom.equalToSuperview().offset(-24)
        }
        */
    }
}
