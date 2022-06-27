//
//  PomodoroImageView.swift
//  FC_pomodoro
//
//  Created by Morgan Kang on 2022/01/22.
//

import UIKit

class PomodoroImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage(named: "pomodoro")
    }
    
    required init?(coder: NSCoder) {
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
