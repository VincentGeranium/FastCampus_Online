//
//  ThreadSafeSyncPerson.swift
//  SerialSyncThreadSafeExample
//
//  Created by Morgan Kang on 2021/12/19.
//

import Foundation

// 💡 엄격한 Thread-safe의 경우.
class ThreadSafeSyncPerson: Person {
    
    let serialQueue = DispatchQueue(label: "com.morgan.person.serial")
    
    // 💡 쓰기 -> Serial(직렬 큐) + Sync(동시) 작업으로 설정.
    override func changeName(firstName: String, lastName: String) {
        serialQueue.sync {
            super.changeName(firstName: firstName, lastName: lastName)
        }
    }
    
    // 💡 읽기 -> Serial(직렬 큐) + Sync(동시) 작업으로 설정.
    override var name: String {
        serialQueue.sync {
            return super.name
        }
    }
}
