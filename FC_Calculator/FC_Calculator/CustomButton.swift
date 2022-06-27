//
//  CustomButton.swift
//  FC_Calculator
//
//  Created by Morgan Kang on 2021/12/31.
//

import UIKit

class CustomButton: UIButton {
    // Property Observer
    var isRound: Bool = false {
        didSet {
            if isRound {
                self.translatesAutoresizingMaskIntoConstraints = false
                self.layer.masksToBounds = true
                // 만약 isRound가 true일 때 높이의 2를 나눈 값 만큼 모서리를 둥글게 만든다.
                self.layer.cornerRadius = self.frame.height / 2
                
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
