//
//  WeatherAllStackView.swift
//  FC_weather
//
//  Created by Morgan Kang on 2022/01/24.
//

import UIKit

class WeatherAllStackView: UIStackView {
    
    let weatherInfoStackView: WeatherInfoStackView = {
        let stackView: WeatherInfoStackView = WeatherInfoStackView(frame: .zero)
        
        [stackView.cityNameLabel,
         stackView.weatherDescriptionLabel].forEach { views in
            stackView.addArrangedSubview(views)
        }
        
        return stackView
    }()
    
    let weatherTempStackView: WeatherTempStackView = {
        let stackView: WeatherTempStackView = WeatherTempStackView(frame: .zero)
        
        [stackView.weatherTempLabel,
         stackView.weatherHighestAndLowestTempStackView].forEach { views in
            stackView.addArrangedSubview(views)
        }
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.alignment = .center
        self.distribution = .fill
        self.spacing = 10
        self.isHidden = true
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
