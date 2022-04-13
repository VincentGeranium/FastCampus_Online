//
//  FeedTableViewCell.swift
//  instagramClone
//
//  Created by Kwangjun Kim on 2022/04/10.
//

import Foundation
import UIKit
import SnapKit

final class FeedTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "FeedTableViewCell"
    
    private lazy var postImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.backgroundColor = .tertiaryLabel
        
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(systemName: "heart")
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(systemName: "message")
        return button
    }()
    
    private lazy var directMessageButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(systemName: "paperplane")
        return button
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(systemName: "bookmark")
        return button
    }()
    
    private lazy var currentLikedUserCountLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13.0, weight: .semibold)
        label.text = "최지연 외 32명이 좋아합니다."
        
        return label
    }()
    
    private lazy var contentstLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13.0, weight: .medium)
        label.numberOfLines = 5
        label.text = "대추가 저절로 붉어질리는 없다. 저 안에 태풍 몇 개, 천둥몇 개, 벼락 몇 개. 현재는 피할 수는 있지만, 그에 따른 결과는 피할 수 없다. 게으른 행동에대해 하늘이 주는 벌은 두가지다. 하나는 자신의 실패이고 또 다른 하나는 내가하지 않은 일을 해낸 옆사람의 성공이다."
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 11.0, weight: .medium)
        label.text = "1일 전."
        
        return label
    }()
    
    func setup() {
        [
            postImageView,
            likeButton,
            commentButton,
            directMessageButton,
            bookmarkButton,
            currentLikedUserCountLabel,
            contentstLabel,
            dateLabel
        ].forEach { self.addSubview($0) }
        
        postImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(postImageView.snp.width)
        }
        
        let buttonWidth: CGFloat = 24.0
        let buttonInset: CGFloat = 16.0
        
        likeButton.snp.makeConstraints {
            $0.top.equalTo(postImageView.snp.bottom).offset(buttonInset)
            $0.leading.equalToSuperview().inset(buttonInset)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        commentButton.snp.makeConstraints {
            $0.top.equalTo(likeButton.snp.top)
            $0.leading.equalTo(likeButton.snp.trailing).offset(12.0)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        directMessageButton.snp.makeConstraints {
            $0.top.equalTo(likeButton.snp.top)
            $0.leading.equalTo(commentButton.snp.trailing).offset(12.0)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.equalTo(likeButton.snp.top)
            $0.trailing.equalToSuperview().inset(buttonInset)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        currentLikedUserCountLabel.snp.makeConstraints {
            $0.top.equalTo(likeButton.snp.bottom).offset(14.0)
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
        }
        
        contentstLabel.snp.makeConstraints {
            $0.top.equalTo(currentLikedUserCountLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(contentstLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
            $0.bottom.equalToSuperview().inset(16.0)
        }
    }
}
