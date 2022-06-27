//
//  WeatherInfoStackView.swift
//  FC_weather
//
//  Created by Morgan Kang on 2022/01/24.
//

import UIKit

class WeatherInfoStackView: UIStackView {
    
    let cityNameLabel: WeatherLabel = {
        let label: WeatherLabel = WeatherLabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.text = "서울"
        
        return label
    }()
    
    let weatherDescriptionLabel: WeatherLabel = {
        let label: WeatherLabel = WeatherLabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.text = "맑음"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.alignment = .center
        self.distribution = .fill
        self.spacing = 8
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
