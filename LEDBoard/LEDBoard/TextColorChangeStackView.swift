//
//  LabelAndButtonsStackOverStackView.swift
//  LEDBoard
//
//  Created by Morgan Kang on 2021/12/23.
//

import UIKit

class TextColorChangeStackView: UIStackView {
    
    let textColorChangeLabel: CustomLabel = {
        let label: CustomLabel = CustomLabel(title: "택스트 색상 설정",
                                             textColor: .black,
                                             backgroundColor: .clear)
        return label
    }()
    
    let buttonsStackView: ButtonsStackView = {
        let stackView: ButtonsStackView = ButtonsStackView()
        
        stackView.firstButton.setButtonImages(image: UIImage(named: "yellow_circle"))
        stackView.secondButton.setButtonImages(image: UIImage(named: "purple_circle"))
        stackView.thirdButton.setButtonImages(image: UIImage(named: "green_circle"))
        
        [stackView.firstButton,
         stackView.secondButton,
         stackView.thirdButton].forEach { views in
            stackView.addArrangedSubview(views)
        }
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.alignment = .leading
        self.distribution = .fillEqually
        self.spacing = 15
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
