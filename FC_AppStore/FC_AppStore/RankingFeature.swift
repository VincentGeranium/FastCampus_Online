//
//  RankingFeature.swift
//  FC_AppStore
//
//  Created by Morgan Kang on 2022/03/15.
//

import Foundation
import UIKit

struct RankingFeature: Decodable {
    let title: String
    let description: String
    let isInPurchaseApp: Bool
}
