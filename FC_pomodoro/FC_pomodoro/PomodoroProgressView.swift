//
//  PomodoroProgressView.swift
//  FC_pomodoro
//
//  Created by Morgan Kang on 2022/01/22.
//

import UIKit

class PomodoroProgressView: UIProgressView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.progress = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
