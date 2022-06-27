//
//  BookMarkCollectionViewFlowLayout.swift
//  FC_Diary
//
//  Created by Morgan Kang on 2022/01/12.
//

import UIKit

class BookMarkCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
//        configureSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSelf() {
        self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.itemSize = CGSize(width: 414, height: 80)
    }
}
