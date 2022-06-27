//
//  ErrorMessage.swift
//  FC_weather
//
//  Created by Morgan Kang on 2022/01/25.
//

import Foundation

// ErrorMessage를 Mapping 할 수 있는 구조체 정의.
    // JSON data를 Mapping 해야하므로 Codable protocol을 채택
struct ErrorMessage: Codable {
    let message: String
}
