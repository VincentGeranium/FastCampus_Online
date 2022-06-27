//
//  FeatureSectionView.swift
//  FC_AppStore
//
//  Created by Morgan Kang on 2022/03/09.
//

import SnapKit
import UIKit

final class FeatureSectionView: UIView {
    private var featureList: [Feature] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(
            FeatureSectionCollectionViewCell.self,
            forCellWithReuseIdentifier: FeatureSectionCollectionViewCell.reuseIdentifier
        )
        
        return collectionView
    }()
    
    private let separatorView = SeparatorView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        fetchData()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeatureSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featureList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureSectionCollectionViewCell.reuseIdentifier, for: indexPath) as? FeatureSectionCollectionViewCell else { return UICollectionViewCell() }
        
        let feature = featureList[indexPath.item]
        
        cell.setup(feature: feature)
        
        return cell
    }
}

extension FeatureSectionView: UICollectionViewDelegateFlowLayout {
    // 셀의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width - 32.0
        let height: CGFloat = self.frame.width
        
        return CGSize(width: width, height: height)
    }
    
    // inset margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let top: CGFloat = 0.0
        let left: CGFloat = 16.0
        let bottom: CGFloat = 0.0
        let right: CGFloat = 16.0

        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    // minimum margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let minimumMargin: CGFloat = 32.0
        return minimumMargin
    }
}

extension FeatureSectionView {
    func setupViews() {
        [
            collectionView,
            separatorView
        ].forEach { self.addSubview($0) }
        
        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(16.0)
            $0.height.equalTo(self.snp.width)
            $0.bottom.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(16)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

private extension FeatureSectionView {
    func fetchData() {
        guard let url = Bundle.main.url(forResource: "Feature", withExtension: "plist") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Feature].self, from: data)
            featureList = result
        } catch {
            print("Error")
        }
    }
}
