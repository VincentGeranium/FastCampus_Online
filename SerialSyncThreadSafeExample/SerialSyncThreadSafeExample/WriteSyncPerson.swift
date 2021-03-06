//
//  WriteSyncPerson.swift
//  SerialSyncThreadSafeExample
//
//  Created by Morgan Kang on 2021/12/19.
//

import Foundation
// π‘ νλ¦°νΈ μμμ μ λλ‘ νκ² λ§λλ λ°©λ².
// π‘ μ½κΈ°λ μΈμ λ μ§ μ κ·Όν  μ μλλ‘(νμ§λ§ μ΄κ²μΌλ‘ μΈνμ¬ Thread-safety λ¬Έμ  λ°μ.)
class WriteSyncPerson: Person {
    let serialQueue = DispatchQueue(label: "com.morgan.person.serial")
    
    // π‘ μ°κΈ° -> Serial + Sync μμμΌλ‘ μ€μ .
    override func changeName(firstName: String, lastName: String) {
        serialQueue.sync {
            super.changeName(firstName: firstName, lastName: lastName)
        }
    }
    
    // π‘ μ½κΈ° -> μ½κΈ°λ μΈμ λ μ§ μ κ·Ό κ°λ₯νλλ‘ νμ§λ§ Thread-safety λ¬Έμ  λ°μ.
    override var name: String {
        return super.name
    }
}
