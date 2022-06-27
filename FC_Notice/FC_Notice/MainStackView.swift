//
//  MainStackView.swift
//  FC_Notice
//
//  Created by Morgan Kang on 2022/02/11.
//

import UIKit

class MainStackView: UIStackView {
    let noticeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "공지사항"
        label.textAlignment = .center
        return label
    }()
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "안내드립니다"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    let detailLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "서비스 이용에 참고 부탁드립니다"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 4
        label.textAlignment = .center
        return label
    }()
    
    let checkDateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "⚙️점검일시"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    let dateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "2021년 1월 31일(월) 00:00-03:00(3시간)"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        return label
    }()
    
    let doneButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        button.backgroundColor = .systemGray5
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillProportionally
        self.spacing = 10
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        setupDoneButton()
    }
    
    private func setupDoneButton() {
        let guide = self.safeAreaLayoutGuide
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            doneButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            doneButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
