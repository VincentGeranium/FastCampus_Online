//
//  ThreadSafeSyncPerson.swift
//  SerialSyncThreadSafeExample
//
//  Created by Morgan Kang on 2021/12/19.
//

import Foundation

// π‘ μκ²©ν Thread-safeμ κ²½μ°.
class ThreadSafeSyncPerson: Person {
    
    let serialQueue = DispatchQueue(label: "com.morgan.person.serial")
    
    // π‘ μ°κΈ° -> Serial(μ§λ ¬ ν) + Sync(λμ) μμμΌλ‘ μ€μ .
    override func changeName(firstName: String, lastName: String) {
        serialQueue.sync {
            super.changeName(firstName: firstName, lastName: lastName)
        }
    }
    
    // π‘ μ½κΈ° -> Serial(μ§λ ¬ ν) + Sync(λμ) μμμΌλ‘ μ€μ .
    override var name: String {
        serialQueue.sync {
            return super.name
        }
    }
}
