//
//  PomodoroTimerLabel.swift
//  FC_pomodoro
//
//  Created by Morgan Kang on 2022/01/22.
//

import UIKit

class PomodoroTimerLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.text = "00:00:00"
        self.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
