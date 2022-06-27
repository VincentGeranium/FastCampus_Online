//
//  AppDetailViewController.swift
//  FC_AppStore
//
//  Created by Morgan Kang on 2022/03/11.
//

import SnapKit
import UIKit
import Kingfisher

final class AppDetailViewController: UIViewController {
    private let today: Today
    
    private let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8.0
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12.0
        
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        
        return button
    }()
    
    init(today: Today) {
        self.today = today
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        setupViews()
        
        // kf를 이용한 이미지 뷰에 이미지 넣기
        if let imageURL = URL(string: today.imageURL) {
            appIconImageView.kf.setImage(
                with: imageURL,
                placeholder: nil,
                options: nil,
                completionHandler: nil
            )
        }
        
        titleLabel.text = today.title
        subTitleLabel.text = today.subTitle
    }
}

// MARK: Private extension
private extension AppDetailViewController {
    func setupViews() {
        [
            appIconImageView,
            titleLabel,
            subTitleLabel,
            downloadButton,
            shareButton
        ].forEach { self.view.addSubview($0) }
        
        appIconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.height.equalTo(100)
            $0.width.equalTo(appIconImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.top)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        downloadButton.snp.makeConstraints {
            $0.width.equalTo(60.0)
            $0.height.equalTo(32.0)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.bottom.equalTo(appIconImageView.snp.bottom)
        }
        
        shareButton.snp.makeConstraints {
            $0.width.equalTo(32.0)
            $0.height.equalTo(32.0)
            $0.bottom.equalTo(appIconImageView.snp.bottom)
            $0.trailing.equalTo(titleLabel.snp.trailing)
        }
    }
    
    @objc private func didTapShareButton() {
        let activityItem: [Any] = [today.title]
        let activityViewController = UIActivityViewController(activityItems: activityItem, applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
}
