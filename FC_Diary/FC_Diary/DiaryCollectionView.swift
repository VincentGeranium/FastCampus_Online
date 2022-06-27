//
//  DiaryCollectionView.swift
//  FC_Diary
//
//  Created by Morgan Kang on 2022/01/12.
//

import UIKit

class DiaryCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        // contentInset -> collectionView에 표시되는 contents의 좌,우,위,아래의 간격이 10만큼씩 생기게 된다.
//        self.collectionViewLayout = UICollectionViewFlowLayout()
//        self.frame = .zero
        self.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        self.collectionViewLayout = UICollectionViewFlowLayout()
        self.register(DiaryCollectionViewCell.self, forCellWithReuseIdentifier: DiaryCollectionViewCell.cellIdentifier)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
