//
//  CustomButton.swift
//  LEDBoard
//
//  Created by Morgan Kang on 2021/12/29.
//

import UIKit

class CustomButton: UIButton {
    var title: String?
    var buttonImage: UIImage?
    var buttonTitleColor: UIColor?
    
    convenience init(title: String?, buttonImage: UIImage?, buttonTitleColor: UIColor?) {
        self.init()
        self.title = title
        self.buttonImage = buttonImage
        self.buttonTitleColor = buttonTitleColor
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButtonTitle(title: self.title)
        setButtonImages(image: self.buttonImage)
        setButtonTitleColors(color: self.buttonTitleColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButtonTitle(title: String? = nil) {
        guard let title = title else {
            return
        }
        self.setTitle(title, for: .normal)
    }
    
    func setButtonImages(image: UIImage? = nil) {
        if let image = image {
            self.setImage(image, for:.normal)
        }
    }
    
    func setButtonTitleColors(color: UIColor? = .systemBlue) {
        if let color = color {
            self.setTitleColor(color, for: .normal)
        }
    }
}
