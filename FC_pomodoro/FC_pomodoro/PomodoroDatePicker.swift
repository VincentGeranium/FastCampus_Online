//
//  PomodoroDatePicker.swift
//  FC_pomodoro
//
//  Created by Morgan Kang on 2022/01/22.
//

import UIKit

class PomodoroDatePicker: UIDatePicker {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.datePickerMode = .countDownTimer
        self.preferredDatePickerStyle = .wheels
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
