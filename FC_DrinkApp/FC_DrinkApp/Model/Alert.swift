//
//  Alert.swift
//  FC_DrinkApp
//
//  Created by Morgan Kang on 2022/02/14.
//

import Foundation
// Alert 객체
    // List에 표현되는 Alert 이라는 객체.
struct Alert: Codable {
    // 고유한 값 이므로 UUID
    var id: String = UUID().uuidString
    // Date 값을 받을 것이므로 -> 이 date 값은 시간이 될 것이다. 즉, 시간 값을 받을 것.
    let date: Date
    // Alert 가 켜져있는 것인지 아닌지를 알기 위해
    var isOn: Bool
    
    // 조금 더 사용성이 있도로 데이트 값을 받으면 바로 Label에 뿌려줄 수 있는 시간 값과 오전 오후 값을 뱉을 수 있도록 추가적으로 만든것 -> date를 받아 time으로 뱉는다.
    var time: String {
        // DateFormatter를 통해 원하는 방식대로 date 모양을 조작 할 수 있다.
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm"
        return timeFormatter.string(from: date)
    }
    
    // time과 같은 방식으로 오전, 오후를 설정해 줄 것.
        // 날자 값을 받아서 현재 한국의 시간이 오전의 값인지 오후의 값인지를 표현하게 된다.
    var meridiem: String {
        let meridiemFormatter = DateFormatter()
        // 오전, 오후를 나타내는 문자열 -> "a"
        meridiemFormatter.dateFormat = "a"
        // 한국으로 Locale 설정
        meridiemFormatter.locale = Locale(identifier: "ko")
        return meridiemFormatter.string(from: date)
    }
}
