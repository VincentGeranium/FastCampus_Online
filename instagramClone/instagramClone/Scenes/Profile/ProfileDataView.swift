//
//  ProfileDataView.swift
//  instagramClone
//
//  Created by Kwangjun Kim on 2022/06/25.
//

import Foundation
import SnapKit
import UIKit

final class ProfileDataView: UIView {
    private let count: Int
    private let title: String
    
    private lazy var countLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.text = "\(self.count)"
        
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.text = self.title
        
        return label
    }()
    
    init(count: Int, title: String) {
        self.count = count
        self.title = title
        // MARK: - super.init 메서드가 뒤에 와야 한다.
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 레이아웃을 잡아주는 메서드를 모아 관리하는 extension
private extension ProfileDataView {
    func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [countLabel,
                                                       titleLabel])
        /// StackView의 방향
        stackView.axis = .vertical
        /// StackView 정렬.
        stackView.alignment = .center
        /// StackView 간격.
        stackView.spacing = 4.0
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
