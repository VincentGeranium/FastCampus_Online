//
//  CardDetailViewController.swift
//  FC_CreditCardList
//
//  Created by Morgan Kang on 2022/02/07.
//

import Foundation
import UIKit
import Lottie

class CardDetailViewController: UIViewController {
    var promotionDetail: PromotionDetail?
    
    let mainCardDetailStackView: MainCardDetailStackView = {
        let stackView: MainCardDetailStackView = MainCardDetailStackView(frame: .zero)
        [stackView.titleLabel,
         stackView.lottieView,
         stackView.periodDetailStackView,
         stackView.conditionDetailStackView,
         stackView.benefitConditionStackView,
         stackView.benefitDetailStackView,
         stackView.benefitDateStackView,
        ].forEach { views in
            stackView.addArrangedSubview(views)
        }
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "카드 혜택 상세"
        self.view.backgroundColor = .white
        configureLottieView()
        setupMainCardDetailStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureContents()
    }
    
    
    private func setupMainCardDetailStackView() {
        let guide = self.view.safeAreaLayoutGuide
        
        mainCardDetailStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mainCardDetailStackView)
        
        NSLayoutConstraint.activate([
            mainCardDetailStackView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            mainCardDetailStackView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            mainCardDetailStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            mainCardDetailStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
        ])
    }
    
    private func configureLottieView() {
        mainCardDetailStackView.animationView.play(completion: nil)
    }
    
    private func configureContents() {
        guard let promotionDetail = promotionDetail else { return }
        
        mainCardDetailStackView.titleLabel.text = """
        \(promotionDetail.companyName)카드 쓰면
        \(promotionDetail.amount)만원 드려요.
        """
        
        mainCardDetailStackView.periodDetailStackView.periodDateDetailLabel.text = promotionDetail.period
        mainCardDetailStackView.conditionDetailStackView.conditionDetailLabel.text = promotionDetail.condition
        mainCardDetailStackView.benefitConditionStackView.benefitConditionLabel.text = promotionDetail.benefitCondition
        mainCardDetailStackView.benefitDetailStackView.benefitDetailLabel.text = promotionDetail.benefitDetail
        mainCardDetailStackView.benefitDateStackView.benefitDateLabel.text = promotionDetail.benefitDate

    }
    
}
