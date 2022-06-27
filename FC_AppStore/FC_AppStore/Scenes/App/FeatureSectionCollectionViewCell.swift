//
//  FeatureSectionCollectionViewCell.swift
//  FC_AppStore
//
//  Created by Morgan Kang on 2022/03/09.
//

import SnapKit
import UIKit
import Kingfisher

final class FeatureSectionCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier: String = "FeatureSectionCollectionViewCell"
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 12.0, weight: .semibold)
        
        return label
    }()
    
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16.0, weight: .semibold)
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 7.0
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.separator.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    func setup(feature: Feature) {
        setupLayout()
        
        typeLabel.text = feature.type
        appNameLabel.text = feature.appName
        descriptionLabel.text = feature.description
        
        if let imageURL = URL(string: feature.imageURL) {
            imageView.kf.setImage(
                with: imageURL,
                placeholder: nil,
                options: nil,
                completionHandler: nil
            )
        }
    }
}

private extension FeatureSectionCollectionViewCell {
    func setupLayout() {
        [
            typeLabel,
            appNameLabel,
            descriptionLabel,
            imageView
        ].forEach {
            self.addSubview($0)
        }
        
        typeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        appNameLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(appNameLabel.snp.bottom).offset(4.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8.0)
        }
    }
}
