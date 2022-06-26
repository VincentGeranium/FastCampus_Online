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
    
    private let photoDataView: ProfileDataView = ProfileDataView(count: 15, title: "게시물")
    private let followerDataView: ProfileDataView = ProfileDataView(count: 100, title: "팔로워")
    private let followingDataView: ProfileDataView = ProfileDataView(count: 7, title: "팔로잉")
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()
        setupLayout()
    }
}
// MARK: - UICollectionViewDataSource의 메서드 관리를 위한 extension
extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier, for: indexPath) as? ProfileCollectionViewCell else { return UICollectionViewCell() }
        
        DispatchQueue.main.async {
            cell.setupLayout()
            cell.setupImage(with: UIImage())
        }
        
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthAndHeight: CGFloat = (collectionView.frame.width / 3) - 1.0
        
        return CGSize(width: widthAndHeight, height: widthAndHeight)
    }
}

// MARK: - Layout 관리를 위한 extension.
private extension ProfileViewController {
    func setupNavigationItems() {
        navigationItem.title = "User name"
        
        let rightBarButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButton)
        )
        
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func didTapRightBarButton() {
        let actionSheet = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        [
            UIAlertAction(
                title: "회원 정보 변경",
                style: .default,
                handler: { alertAction in
                    print("\(String(describing: alertAction.title?.description)) Tap")
                }
            ),
            
            UIAlertAction(
                title: "탈퇴하기",
                style: .destructive,
                handler: { alertAction in
                    print("\(String(describing: alertAction.title?.description)) Tap")
                }
            ),
            
            UIAlertAction(
                title: "닫기",
                style: .cancel,
                handler: { alertAction in
                    print("\(String(describing: alertAction.title?.description)) Tap")
                }
            ),
        ].forEach { actionSheet.addAction($0) }
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func setupLayout() {
        let buttonStackView = UIStackView()
        buttonStackView.spacing = 4.0
        buttonStackView.distribution = .fillEqually
        [followButton, messageButton].forEach { buttonStackView.addArrangedSubview($0) }
        
        let dataStackView = UIStackView()
        dataStackView.spacing = 4.0
        dataStackView.distribution = .fillEqually
        [photoDataView, followerDataView, followingDataView].forEach { dataStackView.addArrangedSubview($0) }
        
        [
            profileImageView,
            dataStackView,
            nameLabel,
            descriptionLabel,
            buttonStackView,
            collectionView,
        ].forEach {
            view.addSubview($0)
        }
        
        let inset: CGFloat = 16.0
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.guide).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.width.equalTo(80.0)
            $0.height.equalTo(profileImageView.snp.width)
        }
        
        dataStackView.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.centerY.equalTo(profileImageView.snp.centerY)
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
        
        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(buttonStackView.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview()
        }
    }
}
