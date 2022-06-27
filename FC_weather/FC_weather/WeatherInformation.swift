//
//  WeatherInformation.swift
//  FC_weather
//
//  Created by Morgan Kang on 2022/01/24.
//

import Foundation

struct WeatherInformation: Codable {
    // weather api 내에서 현재 필요한 정보만 weatherInformation structure에 정의.
    
    // Weather 내의 키가 mapping 될 수 있게 property 정의.
        // weather은 배열 타입이므로 배열 타입으로 정의.
    let weather: [Weather]
    let temp: Temp
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case temp = "main"
        case name
    }
}

// weather 구조체 정의
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// main 구조체 정의.
struct Temp: Codable {
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    // JSON Key와 다른 Property의 이름을 가지고 있으므로 CodingKeys에 CodingKey protocol을 준수하게 구현.
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}
