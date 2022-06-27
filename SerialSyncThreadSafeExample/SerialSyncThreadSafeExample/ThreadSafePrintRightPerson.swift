//
//  ThreadSafePrintRightPerson.swift
//  SerialSyncThreadSafeExample
//
//  Created by Morgan Kang on 2021/12/19.
//

import Foundation
// 💡 엄격한 Therad-safe이면서도 Print도 제대로 되는 코드.
// 💡 객체 설계를 다시할 필요가 있다.
    // 항상 이렇게 설계해야하는 것은 아니다, 여기서의 케이스를 고려했을때의 설계 방식.

class ThreadSafePrintRightPerson: Person {
    let serialQueue = DispatchQueue(label: "com.morgan.person.serial")
    
    // 💡 쓰기 -> Serial + Sync 작업으로 설정
    override func changeName(firstName: String, lastName: String) {
        serialQueue.sync {
            super.changeName(firstName: firstName, lastName: lastName)
            // 💡 print를 이곳에 넣음으로서 print도 제대로 된다.
            print("현재 이름(safe): \(self.name)")
        }
    }
    
    // 💡 읽기 -> 읽기 작업은 Sync 처리를 하지 않는다.
    override var name: String {
        return super.name
    }
}
