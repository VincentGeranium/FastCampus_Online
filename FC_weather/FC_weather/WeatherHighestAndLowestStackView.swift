//
//  WeatherHighestAndLowestStackView.swift
//  FC_weather
//
//  Created by Morgan Kang on 2022/01/24.
//

import UIKit

class WeatherHighestAndLowestStackView: UIStackView {
    
    let maxTempLabel: WeatherLabel = {
        let label: WeatherLabel = WeatherLabel()
        label.text = "최고:30℃"
        return label
    }()
    
    let minTempLabel: WeatherLabel = {
        let label: WeatherLabel = WeatherLabel()
        label.text = "최저:20℃"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 20
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
