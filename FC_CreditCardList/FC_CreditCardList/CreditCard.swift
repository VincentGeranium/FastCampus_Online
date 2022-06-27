//
//  CreditCard.swift
//  FC_CreditCardList
//
//  Created by Morgan Kang on 2022/02/07.
//

import Foundation
import UIKit

struct CreditCard: Codable {
    let id: Int
    let rank: Int
    let name: String
    let cardImageURL: String
    // promotionDetail은 객체이므로 depth를 한 번 갖기 때문에 따로 PromotionDetail 객체를 만들어준다.
    let promotionDetail: PromotionDetail
    // 추후에 사용자가 카드를 선택했을 때 생성이 될 것이므로, 그 전까지는 nil값을 가진다 때문에 Optional Bool 값을 갖는다.
    let isSelected: Bool?
}

struct PromotionDetail: Codable {
    let companyName: String
    let period: String
    let amount: Int
    let condition: String
    let benefitCondition: String
    let benefitDetail: String
    let benefitDate: String
}
