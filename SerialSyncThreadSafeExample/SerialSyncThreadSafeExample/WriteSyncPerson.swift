//
//  WriteSyncPerson.swift
//  SerialSyncThreadSafeExample
//
//  Created by Morgan Kang on 2021/12/19.
//

import Foundation
// 💡 프린트 작업을 제대로 하게 만드는 방법.
// 💡 읽기는 언제든지 접근할 수 있도록(하지만 이것으로 인하여 Thread-safety 문제 발생.)
class WriteSyncPerson: Person {
    let serialQueue = DispatchQueue(label: "com.morgan.person.serial")
    
    // 💡 쓰기 -> Serial + Sync 작업으로 설정.
    override func changeName(firstName: String, lastName: String) {
        serialQueue.sync {
            super.changeName(firstName: firstName, lastName: lastName)
        }
    }
    
    // 💡 읽기 -> 읽기는 언제든지 접근 가능하도록 하지만 Thread-safety 문제 발생.
    override var name: String {
        return super.name
    }
}
