//
//  NoticeView.swift
//  FC_Notice
//
//  Created by Morgan Kang on 2022/02/11.
//

import UIKit

class NoticeView: UIView {
    
    let mainStackView: MainStackView = {
        let stackView: MainStackView = MainStackView(frame: .zero)
        
        [stackView.noticeLabel,
         stackView.titleLabel,
         stackView.detailLabel,
         stackView.checkDateLabel,
         stackView.dateLabel,
         stackView.doneButton
        ].forEach { views in
            stackView.addArrangedSubview(views)
        }
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        setupMainStackView()
    }
    
    private func setupMainStackView() {
        let guide = self.safeAreaLayoutGuide
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20),
        ])
    }
    

}
