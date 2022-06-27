//
//  TextColorSettingLabel.swift
//  LEDBoard
//
//  Created by Morgan Kang on 2021/12/23.
//

import UIKit

class TextColorSettingLabel: UILabel {
    
    convenience init(title: String?) {
        self.init()
        setupLabel(title: title)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel(title: String? = "텍스트 색상 설정") {
        guard let title = title else {
            return
        }
        self.text = title
        self.textColor = .black
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
