//
//  AllStackView.swift
//  FC_Calculator
//
//  Created by Morgan Kang on 2022/01/01.
//

import UIKit

class AllStackView: UIStackView {
    
    let firstStackView: FirstStackView = {
        let stackView: FirstStackView = FirstStackView()

        [stackView.acButton,
         stackView.divideButton].forEach { views in
            stackView.addArrangedSubview(views)
        }

        return stackView
    }()

    let secondStackView: SecondStackView = {
        let stackView: SecondStackView = SecondStackView()

        [stackView.sevenButton,
         stackView.eightButton,
         stackView.nineButton,
         stackView.timesButton].forEach { views in
            stackView.addArrangedSubview(views)
        }

        return stackView
    }()

    let thirdStackView: ThirdStackView = {
        let stackView: ThirdStackView = ThirdStackView()

        [stackView.fourButton,
         stackView.fiveButton,
         stackView.sixButton,
         stackView.minusButton].forEach { views in
            stackView.addArrangedSubview(views)
        }

        return stackView
    }()

    let fourthStackView: FourthStackView = {
        let stackView: FourthStackView = FourthStackView()

        [stackView.oneButton,
         stackView.twoButton,
         stackView.threeButton,
         stackView.plusButton].forEach { views in
            stackView.addArrangedSubview(views)
        }

        return stackView
    }()

    let fifthStackView: FifthStackView = {
        let stackView: FifthStackView = FifthStackView()

        [stackView.zeroButton,
         stackView.dotButton,
         stackView.resultButton].forEach { views in
            stackView.addArrangedSubview(views)
        }

        return stackView
    }()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 8

    }
       
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
