//
//  BookMarkCollectionView.swift
//  FC_Diary
//
//  Created by Morgan Kang on 2022/01/12.
//

import UIKit

class BookMarkCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = .white
        self.register(BookMarkCollectionViewCell.self, forCellWithReuseIdentifier: BookMarkCollectionViewCell.cellIdentifier)
        self.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
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
