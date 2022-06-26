//
//  ProfileCollectionViewCell.swift
//  instagramClone
//
//  Created by Kwangjun Kim on 2022/06/26.
//

import Foundation
import UIKit
import SnapKit

final class ProfileCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier: String = "ProfileCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        
        return imageView
    }()
    
}

extension ProfileCollectionViewCell {
    func setupImage(with image: UIImage) {
        self.imageView.image = image
    }
}

extension ProfileCollectionViewCell {
    func setupLayout() {
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        imageView.backgroundColor = .tertiaryLabel
    }
}
