//
//  WeatherTextField.swift
//  FC_weather
//
//  Created by Morgan Kang on 2022/01/24.
//

import UIKit

class WeatherTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.borderWidth = 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
