//
//  KeyPadView.swift
//  FC_Calculator
//
//  Created by Morgan Kang on 2021/12/31.
//

import UIKit

class KeyPadView: UIView {
    
    let allStackView: AllStackView = {
        let stackView: AllStackView = AllStackView()
        
        [stackView.firstStackView,
         stackView.secondStackView,
         stackView.thirdStackView,
         stackView.fourthStackView,
         stackView.fifthStackView,
        ].forEach { allStackViews in
            stackView.addArrangedSubview(allStackViews)
        }
        
        return stackView
    }()
    
    convenience init(target: Any) {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black

        setupAllStackView()
        setupSecondStackView()
        setupThirdStackView()
        setupFourthStackView()
        setupFifthStackVView()
        setupFirstStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupAllStackView() {
        allStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(allStackView)
        
        let bottom = allStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            allStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            allStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            allStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            bottom,
        ])
        bottom.priority = UILayoutPriority(rawValue: 750)
    }
    
    private func setupFirstStackView() {
        allStackView.firstStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allStackView.firstStackView.heightAnchor.constraint(equalTo: self.allStackView.firstStackView.heightAnchor),
            allStackView.firstStackView.acButton.trailingAnchor.constraint(equalTo: self.allStackView.secondStackView.nineButton.trailingAnchor),
            allStackView.firstStackView.divideButton.heightAnchor.constraint(equalTo: self.allStackView.firstStackView.divideButton.widthAnchor, multiplier: 1/1),
        ])
    }
    
    private func setupSecondStackView() {
        allStackView.secondStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allStackView.secondStackView.heightAnchor.constraint(equalTo: self.allStackView.firstStackView.heightAnchor),
            allStackView.secondStackView.sevenButton.heightAnchor.constraint(equalTo: self.allStackView.secondStackView.sevenButton.widthAnchor, multiplier: 1/1),
            allStackView.secondStackView.eightButton.heightAnchor.constraint(equalTo: self.allStackView.secondStackView.eightButton.widthAnchor, multiplier: 1/1),
            allStackView.secondStackView.nineButton.heightAnchor.constraint(equalTo: self.allStackView.secondStackView.nineButton.widthAnchor, multiplier: 1/1),
            allStackView.secondStackView.timesButton.heightAnchor.constraint(equalTo: self.allStackView.secondStackView.timesButton.widthAnchor, multiplier: 1/1),
        ])
    }
    
    private func setupThirdStackView() {
        allStackView.thirdStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allStackView.thirdStackView.heightAnchor.constraint(equalTo: self.allStackView.firstStackView.heightAnchor),
            allStackView.thirdStackView.fourButton.heightAnchor.constraint(equalTo: self.allStackView.thirdStackView.fourButton.widthAnchor, multiplier: 1/1),
            allStackView.thirdStackView.fiveButton.heightAnchor.constraint(equalTo: self.allStackView.thirdStackView.fiveButton.widthAnchor, multiplier: 1/1),
            allStackView.thirdStackView.sixButton.heightAnchor.constraint(equalTo: self.allStackView.thirdStackView.sixButton.widthAnchor, multiplier: 1/1),
            allStackView.thirdStackView.minusButton.heightAnchor.constraint(equalTo: self.allStackView.thirdStackView.minusButton.widthAnchor, multiplier: 1/1),
        ])
    }
    
    private func setupFourthStackView() {
        allStackView.fourthStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allStackView.fourthStackView.heightAnchor.constraint(equalTo: self.allStackView.firstStackView.heightAnchor),
            allStackView.fourthStackView.oneButton.heightAnchor.constraint(equalTo: self.allStackView.fourthStackView.oneButton.widthAnchor, multiplier: 1/1),
            allStackView.fourthStackView.twoButton.heightAnchor.constraint(equalTo: self.allStackView.fourthStackView.twoButton.widthAnchor, multiplier: 1/1),
            allStackView.fourthStackView.threeButton.heightAnchor.constraint(equalTo: self.allStackView.fourthStackView.threeButton.widthAnchor, multiplier: 1/1),
            allStackView.fourthStackView.plusButton.heightAnchor.constraint(equalTo: self.allStackView.fourthStackView.plusButton.widthAnchor, multiplier: 1/1),
        ])
    }
    
    private func setupFifthStackVView() {
        allStackView.fifthStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allStackView.fifthStackView.heightAnchor.constraint(equalTo: self.allStackView.firstStackView.heightAnchor),
            allStackView.fifthStackView.zeroButton.trailingAnchor.constraint(equalTo: self.allStackView.fourthStackView.twoButton.trailingAnchor),
            allStackView.fifthStackView.dotButton.heightAnchor.constraint(equalTo: self.allStackView.fifthStackView.dotButton.widthAnchor, multiplier: 1/1),
            allStackView.fifthStackView.resultButton.heightAnchor.constraint(equalTo: self.allStackView.fifthStackView.resultButton.widthAnchor, multiplier: 1/1),
        ])
    }
}
