//
//  ButtonsStackView.swift
//  LEDBoard
//
//  Created by Morgan Kang on 2021/12/23.
//

import UIKit

class ButtonsStackView: UIStackView {
    
    var buttonTitle: String?
    var buttonTitleColor: UIColor?
    var buttonImages: UIImage?

    let firstButton: CustomButton = {
        let button: CustomButton = CustomButton()
        return button
    }()
    

    let secondButton: CustomButton = {
        let button: CustomButton = CustomButton()
        return button
    }()
    
    let thirdButton: CustomButton = {
        let button: CustomButton = CustomButton()
        return button
    }()
    
    convenience init(buttonTitle: String? = nil, buttonTitleColor: UIColor? = nil, buttonImages: UIImage? = nil) {
        self.init()
        self.buttonTitle = buttonTitle
        self.buttonTitleColor = buttonTitleColor
        self.buttonImages = buttonImages
        setButtonTitleColors()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.spacing = 13
        self.distribution = .fillEqually
        set()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    func set() {
        firstButton.setButtonTitle(title: self.buttonTitle)
        secondButton.setButtonTitle(title: self.buttonTitle)
        thirdButton.setButtonTitle(title: self.buttonTitle)

        firstButton.setButtonImages(image: self.buttonImages)
        secondButton.setButtonImages(image: self.buttonImages)
        thirdButton.setButtonImages(image: self.buttonImages)
    }
    
    func setButtonTitleColors() {
        firstButton.setButtonTitleColors(color: self.buttonTitleColor)
        secondButton.setButtonTitleColors(color: self.buttonTitleColor)
        thirdButton.setButtonTitleColors(color: self.buttonTitleColor)
    }


}
