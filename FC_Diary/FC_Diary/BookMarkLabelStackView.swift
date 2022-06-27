//
//  BookMarkLabelStackView.swift
//  FC_Diary
//
//  Created by Morgan Kang on 2022/01/12.
//

import UIKit

class BookMarkLabelStackView: UIStackView {
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "title"
        return label
    }()
    
    let dateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "date"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .vertical
        self.spacing = 12
        self.distribution = .fill
        self.alignment = .fill
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
