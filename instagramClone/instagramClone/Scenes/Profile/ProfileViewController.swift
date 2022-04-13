//
//  ProfileViewController.swift
//  instagramClone
//
//  Created by Kwangjun Kim on 2022/04/13.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    private lazy var profileImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.layer.cornerRadius = 40.0
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "User Name."
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "오늘을 기억하고, 실패를 자양분 삼아 커가는 사람이 되자. 절대로 넘어졌다고 그대로 넘어져 있지 않고 스스로 일어나는 법을 배우는 사람이 되자. 사람을 쓰러지고 지치고 힘들어도 다시 일어나는 법을 배우며 커가는 존재이다. 걸음마를 배우는 아이처럼 넘어졌다 일어서기를 반복하여 걷고 뛸 수 있는 사람이 되자."
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var followButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("팔로우", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        button.backgroundColor = .systemBlue
        
        button.layer.cornerRadius = 3.0
        
        return button
    }()
    
    private lazy var messageButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("메세지", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        button.backgroundColor = .white
        
        button.layer.cornerRadius = 3.0
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.tertiaryLabel.cgColor
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()
        setupLayout()
    }
}

private extension ProfileViewController {
    func setupNavigationItems() {
        navigationItem.title = "User name"
        
        let rightBarButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain,
            target: self,
            action: nil
        )
        
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func setupLayout() {
        let buttonStackView = UIStackView()
        buttonStackView.spacing = 4.0
        buttonStackView.distribution = .fillEqually
        [followButton, messageButton].forEach { buttonStackView.addArrangedSubview($0) }
        
        [
            profileImageView,
            nameLabel,
            descriptionLabel,
            buttonStackView
        ].forEach {
            view.addSubview($0)
        }
        
        let inset: CGFloat = 16.0
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.width.equalTo(80.0)
            $0.height.equalTo(profileImageView.snp.width)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(12.0)
            $0.leading.equalTo(profileImageView.snp.leading)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6.0)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalTo(nameLabel.snp.trailing)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12.0)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalTo(nameLabel.snp.trailing)
        }
    }
}
