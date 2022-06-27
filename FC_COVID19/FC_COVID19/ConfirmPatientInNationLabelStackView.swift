//
//  ConfirmPatientInNationLabelStackView.swift
//  FC_COVID19
//
//  Created by Morgan Kang on 2022/01/26.
//

import UIKit

class ConfirmPatientInNationLabelStackView: UIStackView {
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "국내 확진자"
        return label
    }()
    
    let contentsLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Label"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.alignment = .center
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
