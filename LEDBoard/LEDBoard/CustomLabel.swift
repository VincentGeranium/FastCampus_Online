//
//  CustomLabel.swift
//  LEDBoard
//
//  Created by Morgan Kang on 2021/12/24.
//

import UIKit

class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, textColor: UIColor, backgroundColor: UIColor) {
        self.init(frame: .zero)
        set(title: title, textColor: textColor, backgroundColor: backgroundColor)
    }
    
    func set(title: String, textColor: UIColor, backgroundColor: UIColor) {
        self.text = title
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }

}
