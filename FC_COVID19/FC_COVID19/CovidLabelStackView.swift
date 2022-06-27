//
//  CovidLabelStackView.swift
//  FC_COVID19
//
//  Created by Morgan Kang on 2022/01/26.
//

import UIKit

class CovidLabelStackView: UIStackView {
    
    let confirmPatientStackView: ConfirmPatientInNationLabelStackView = {
        let stackView: ConfirmPatientInNationLabelStackView = ConfirmPatientInNationLabelStackView(frame: .zero)
        
        [stackView.titleLabel,
         stackView.contentsLabel].forEach { views in
            stackView.addArrangedSubview(views)
        }
        
        return stackView
    }()
    
    let newConfirmPatientStackView: NewConfirmPatientInNationStackView = {
        let stackView: NewConfirmPatientInNationStackView = NewConfirmPatientInNationStackView(frame: .zero)
        
        [stackView.titleLabel,
         stackView.contentsLabel].forEach { views in
            stackView.addArrangedSubview(views)
        }
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.alignment = .center
        self.distribution = .fillEqually
        self.spacing = 0
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
