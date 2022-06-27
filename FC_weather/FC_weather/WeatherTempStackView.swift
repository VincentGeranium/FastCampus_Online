//
//  WeatherTempStackView.swift
//  FC_weather
//
//  Created by Morgan Kang on 2022/01/24.
//

import UIKit

class WeatherTempStackView: UIStackView {
    
    let weatherTempLabel: WeatherLabel = {
        let label: WeatherLabel = WeatherLabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.text = "23℃"
        return label
    }()
    
    let weatherHighestAndLowestTempStackView: WeatherHighestAndLowestStackView = {
        let stackView: WeatherHighestAndLowestStackView = WeatherHighestAndLowestStackView(frame: .zero)
        
        [stackView.maxTempLabel,
         stackView.minTempLabel].forEach { views in
            stackView.addArrangedSubview(views)
        }
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.alignment = .center
        self.distribution = .fill
        self.spacing = 3
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
