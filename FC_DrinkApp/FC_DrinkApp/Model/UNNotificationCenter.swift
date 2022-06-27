//
//  UNNotificationCenter.swift
//  FC_DrinkApp
//
//  Created by Morgan Kang on 2022/02/14.
//

import Foundation
import UserNotifications

extension UNUserNotificationCenter {
    // 알럿 객체를 받아서 리퀘스트를 만들고 최종적으로 노티피케이션 센터에 추가하는 메서드.
    func addNotificationRequest(by alert: Alert) {
        // content 설정
            // 알림에 대한 content 설정.
        let content = UNMutableNotificationContent()
        content.title = "물 마실 시간입니다💦"
        content.body = "세계보건기구(WHO)가 권장하는 하루 물 섭취량은 1.5~2L 입니다."
        content.sound = .default
        content.badge = 1
        
        // component 선언
            // 첫 번째 파라미터에 배열로 시간과 분 컴포넌트를 넣겠다고 설정.
            // 두 번째 파라미터는 어느 Date에서 이런 시간 과 분을 얻을 것인가를 설정.
        let component = Calendar.current.dateComponents([.hour, .minute], from: alert.date)
        // trigger 선언
            // 첫 번째 파라미터인 dateMatching은 어떤 date 조건으로 할 것인지 DateComponent를 전달해야 한다.
            // 두 번째 파라미터인 repeats는 이 조건을 계속 반복 할 것인지 bool로 전달해야 한다. -> 스위치의 on,off 상태에 따라 스위치가 켜져있다면 계속 반복을 해주면 되고 꺼져있다면 repeats을 false로 해주면 된다.
                // 이번 프로젝트에서 날짜는 상관 없고 해당 시간과 분만 있으면 된다.
                // 따라서 날짜는 Alert 객채가 가지고 있으니 해당 Date를 시간, 분 형태의 DateComponent 형태로 만들어 주면 된다.
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: alert.isOn)
        
        // request 선언
        let request = UNNotificationRequest(identifier: alert.id, content: content, trigger: trigger)
        
        self.add(request, withCompletionHandler: nil)
    }
}
