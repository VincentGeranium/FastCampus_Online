//
//  PomodoroButtonStackView.swift
//  FC_pomodoro
//
//  Created by Morgan Kang on 2022/01/22.
//

import UIKit

class PomodoroButtonStackView: UIStackView {
    
    var cancelButton: PomodoroCustomButton = {
        var button: PomodoroCustomButton = PomodoroCustomButton(frame: .zero)
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    var toggleButton: PomodoroCustomButton = {
        var button: PomodoroCustomButton = PomodoroCustomButton(frame: .zero)
        button.setTitle("시작", for: .normal)
        button.setTitle("일시정지", for: .selected)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.distribution = .fillEqually
        self.spacing = 80
        self.alignment = .fill
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
