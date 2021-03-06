//
//  ThreadSafePrintRightPerson.swift
//  SerialSyncThreadSafeExample
//
//  Created by Morgan Kang on 2021/12/19.
//

import Foundation
// ๐ก ์๊ฒฉํ Therad-safe์ด๋ฉด์๋ Print๋ ์ ๋๋ก ๋๋ ์ฝ๋.
// ๐ก ๊ฐ์ฒด ์ค๊ณ๋ฅผ ๋ค์ํ  ํ์๊ฐ ์๋ค.
    // ํญ์ ์ด๋ ๊ฒ ์ค๊ณํด์ผํ๋ ๊ฒ์ ์๋๋ค, ์ฌ๊ธฐ์์ ์ผ์ด์ค๋ฅผ ๊ณ ๋ คํ์๋์ ์ค๊ณ ๋ฐฉ์.

class ThreadSafePrintRightPerson: Person {
    let serialQueue = DispatchQueue(label: "com.morgan.person.serial")
    
    // ๐ก ์ฐ๊ธฐ -> Serial + Sync ์์์ผ๋ก ์ค์ 
    override func changeName(firstName: String, lastName: String) {
        serialQueue.sync {
            super.changeName(firstName: firstName, lastName: lastName)
            // ๐ก print๋ฅผ ์ด๊ณณ์ ๋ฃ์์ผ๋ก์ print๋ ์ ๋๋ก ๋๋ค.
            print("ํ์ฌ ์ด๋ฆ(safe): \(self.name)")
        }
    }
    
    // ๐ก ์ฝ๊ธฐ -> ์ฝ๊ธฐ ์์์ Sync ์ฒ๋ฆฌ๋ฅผ ํ์ง ์๋๋ค.
    override var name: String {
        return super.name
    }
}
