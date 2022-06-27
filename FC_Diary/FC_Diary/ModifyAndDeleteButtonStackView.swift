//
//  modifyAndDeleteButtonStackView.swift
//  FC_Diary
//
//  Created by Morgan Kang on 2022/01/13.
//

import UIKit

class ModifyAndDeleteButtonStackView: UIStackView {
    
    let modifyButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("수정", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    let deleteButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 50
    }
    
    required init(coder: NSCoder) {
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
