//
//  DiaryDetailLabelStackView.swift
//  FC_Diary
//
//  Created by Morgan Kang on 2022/01/12.
//

import UIKit

class DiaryDetailLabelStackView: UIStackView {
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    var diaryTitleLabel: UILabel = {
        var label: UILabel = UILabel()
        label.numberOfLines = 3
        label.text = ""
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 12
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
