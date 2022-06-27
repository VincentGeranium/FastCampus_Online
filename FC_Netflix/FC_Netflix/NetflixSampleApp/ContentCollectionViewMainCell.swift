//
//  ContentCollectionViewMainCell.swift
//  FC_Netflix
//
//  Created by Morgan Kang on 2022/02/20.
//

import Foundation
import UIKit
import SnapKit

class ContentCollectionViewMainCell: UICollectionViewCell {
    static let reuseIdentifier: String = "ContentCollectionViewMainCell"
    
    let baseStackView: UIStackView = UIStackView()
    let menuStackView: UIStackView = UIStackView()
    
    let tvButton: UIButton = UIButton()
    let movieButton: UIButton = UIButton()
    let categoryButton: UIButton = UIButton()
    
    let imageView: UIImageView = UIImageView()
    let descriptionLabel: UILabel = UILabel()
    let contentStackView: UIStackView = UIStackView()
    
    let plusButton: UIButton = UIButton()
    let playButton: UIButton = UIButton()
    let infoButton: UIButton = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [baseStackView, menuStackView].forEach { contentView.addSubview($0)}
        
        // baseStackView
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.distribution = .fillProportionally
        baseStackView.spacing = 5
        
        [imageView, descriptionLabel, contentStackView].forEach { baseStackView.addArrangedSubview($0) }
        
        // ImageView
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.width.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        
        // DescriptionLabel
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .white
        descriptionLabel.sizeToFit()
        
        // ContentStackView
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.distribution = .equalCentering
        contentStackView.spacing = 20
        
        [plusButton, infoButton].forEach {
            
            $0.titleLabel?.font = .systemFont(ofSize: 13)
            $0.setTitleColor(.white, for: .normal)
            $0.imageView?.tintColor = .white
            $0.adjustVerticalLayout(5)
        }
        
        plusButton.setTitle("내가 찜한 콘텐츠", for: .normal)
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(plusButtonTapped(_:)), for: .touchUpInside)
        
        infoButton.setTitle("정보", for: .normal)
        infoButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonTapped(_:)), for: .touchUpInside)
        
        
        
        playButton.setTitle("▶︎ 재생", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.backgroundColor = .white
        playButton.layer.cornerRadius = 3
        playButton.snp.makeConstraints {
            $0.width.equalTo(90)
            $0.height.equalTo(30)
        }
        playButton.addTarget(self, action: #selector(playButtonTapped(_:)), for: .touchUpInside)
        
        [plusButton, playButton, infoButton].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        contentStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
        
        baseStackView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        // menuStackView
        menuStackView.axis = .horizontal
        menuStackView.alignment = .center
        menuStackView.distribution = .equalSpacing
        menuStackView.spacing = 20
        
        [tvButton, movieButton, categoryButton].forEach {
            menuStackView.addArrangedSubview($0)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 1
            $0.layer.shadowRadius = 3
        }
        
        tvButton.setTitle("TV 프로그램", for: .normal)
        movieButton.setTitle("영화", for: .normal)
        categoryButton.setTitle("카테고리 ▼", for: .normal)
        
        tvButton.addTarget(self, action: #selector(tvButtonTapped(_:)), for: .touchUpInside)
        movieButton.addTarget(self, action: #selector(movieButtonTapped(_:)), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
        
        
        menuStackView.snp.makeConstraints {
            $0.top.equalTo(baseStackView)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    @objc func tvButtonTapped(_ sender: UIButton) {
        print("TEST: tv button tapped")
    }
    
    @objc func movieButtonTapped(_ sender: UIButton) {
        print("TEST: movie button tapped")
    }
    
    @objc func categoryButtonTapped(_ sender: UIButton){
        print("TEST: category button tapped")
    }
    
    @objc func plusButtonTapped(_ sender: UIButton){
        print("TEST: plus button tapped")
    }
    
    @objc func infoButtonTapped(_ sender: UIButton){
        print("TEST: info button tapped")
    }
    
    @objc func playButtonTapped(_ sender: UIButton){
        print("TEST: play button tapped")
    }
    
    
}
