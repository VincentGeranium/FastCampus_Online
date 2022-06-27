//
//  MainCardDetailStackView.swift
//  FC_CreditCardList
//
//  Created by Morgan Kang on 2022/02/07.
//

import UIKit
import Lottie

class MainCardDetailStackView: UIStackView {
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = """
        신용카드 쓰면
        0만원 드려요
        """
        label.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let lottieView: AnimationView = {
        let view: AnimationView = AnimationView(frame: .zero)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let animationView: AnimationView = {
        let view: AnimationView = AnimationView(name: "money")
        view.loopMode = .loop
        return view
    }()
    
    let periodDetailStackView: PeriodDetailStackView = {
        let stackView: PeriodDetailStackView = PeriodDetailStackView(frame: .zero)
        
        [stackView.periodDateTitleLabel,
         stackView.periodDateDetailLabel,
        ].forEach { views in
            stackView.addArrangedSubview(views)
        }
        
        return stackView
    }()
    
    let conditionDetailStackView: ConditionDetailStackView = {
        let stackView: ConditionDetailStackView = ConditionDetailStackView(frame: .zero)
        [stackView.conditionDetailTitleLabel,
         stackView.conditionDetailLabel
        ].forEach { views in
            stackView.addArrangedSubview(views)
        }
        return stackView
    }()
    
    let benefitConditionStackView: BenefitConditionStackView = {
        let stackView: BenefitConditionStackView = BenefitConditionStackView(frame: .zero)
        
        [stackView.benefitConditionTitle,
         stackView.benefitConditionLabel,
        ].forEach { views in
            stackView.addArrangedSubview(views)
        }
        
        return stackView
    }()
    
    let benefitDetailStackView: BenefitDetailStackView = {
        let stackView: BenefitDetailStackView = BenefitDetailStackView(frame: .zero)
        
        [stackView.benefitDetailTitleLabel,
         stackView.benefitDetailLabel,
        ].forEach { views in
            stackView.addArrangedSubview(views)
        }
        
        return stackView
    }()
    
    let benefitDateStackView: BenefitDateStackView = {
        let stackView: BenefitDateStackView = BenefitDateStackView(frame: .zero)
        
        [stackView.benefitDateTitleLabel,
         stackView.benefitDateLabel,
        ].forEach { views in
            stackView.addArrangedSubview(views)
        }
        
        return stackView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 20
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        setupLottieView()
        configureAnimationView()
    }
    
    private func setupLottieView() {
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lottieView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureAnimationView() {
        let guide = self.lottieView.safeAreaLayoutGuide
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.frame = lottieView.bounds
        self.lottieView.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: guide.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: guide.widthAnchor),
        ])
    }
}
