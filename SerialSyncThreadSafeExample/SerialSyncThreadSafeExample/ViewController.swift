//
//  ViewController.swift
//  SerialSyncThreadSafeExample
//
//  Created by Morgan Kang on 2021/12/19.
//

import UIKit

class ViewController: UIViewController {
    
    let nameList: [(String, String)] = [("모건", "강"), ("민희", "조"), ("민경", "조"), ("이주", "임"), ("양례", "강"), ("미옥", "강")]
    
    let concurrentQueue = DispatchQueue(label: "com.morgan.concurrent",
                                         qos: .unspecified,
                                         attributes: .concurrent,
                                         autoreleaseFrequency: .inherit,
                                         target: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // 💡경쟁상황 발생하는 경우
//        changeNameRace()
        // 💡 경쟁상황이 발생하지 않는 Thread-safe한 처리의 경우
        changeNameSafely()
        // 💡 쓰기 작업만 Sync 처리한 경우(Thread-safe문제는 발생한다)
//        writeSyncronously()
        // 💡Thread-safe 하면서 print도 제대로 하는 경우 (케이스를 고려한 재설계)
//        changeNameSafelyPrintRightly()
        
        
    }
    
    // 경쟁상황 발생하는 경우의 함수 정의
    func changeNameRace() {
        let person = Person(firstName: "길동", lastName: "강")
        let nameChageGroup = DispatchGroup()
        
        // async로 custom concurrent Qeueue에 보내서(동시적으로) 이름 바꾸기.
        for (idx, name) in nameList.enumerated() {
            concurrentQueue.async(group: nameChageGroup,
                                  qos: .unspecified,
                                  flags: []) {
                usleep(UInt32(10_000 * idx))
                person.changeName(firstName: name.0, lastName: name.1)
                print("현재의 이름: \(person.name)")
            }
        }
        
        // Dispatch Group 작업이 다 끝나면 마지막 이름 알려주기.
        nameChageGroup.notify(qos: .unspecified,
                              flags: [],
                              queue: DispatchQueue.main) {
            print("마지막 이름은?: \(person.name)")
        }
        // 다 할때까지 기다리기.
        nameChageGroup.wait()
    }
    
    // 경쟁 상황이 발생하지 않는 Thread-safe한 처리의 함수 정의.
    func changeNameSafely() {
        let threadSafeNameGroup = DispatchGroup()
        
        let threadSafeSyncPerson = ThreadSafeSyncPerson(firstName: "길동", lastName: "강")
        
        // Thread-safe 객체를 동시작업으로 진행해보기.
        for(idx, name) in nameList.enumerated() {
            usleep(UInt32(10_000 * idx))
            threadSafeSyncPerson.changeName(firstName: name.0, lastName: name.1)
            // 프린트하는 자체도 큐에 들어가는 순서에 따라 이상한 순서로 프린트 되는 일이 발생할 수 있다.
            // 그럼에도 불구하고 여러 쓰레드에서 한꺼번에 접근을 막기 때문에 Thread-safe한 처리가 맞다
            print("현재 이름(safe): \(threadSafeSyncPerson.name)")
        }
        threadSafeNameGroup.notify(qos: .unspecified,
                                   flags: [],
                                   queue: DispatchQueue.main) {
            print("마지막 이름은?(safe): \(threadSafeSyncPerson.name)")
        }
    }
    
    // 쓰기 작업면 Sync 처리한 경우의 함수 정의.
    func writeSyncronously() {
        let writeSyncNameGroup = DispatchGroup()
        
        let writeSyncPerson = WriteSyncPerson(firstName: "길동", lastName: "강")
        
        // 동시작업을 진행해보기
        for (idx, name) in nameList.enumerated() {
            concurrentQueue.async(group: writeSyncNameGroup, qos: .unspecified, flags: []) {
                usleep(UInt32(10_000 * idx))
                writeSyncPerson.changeName(firstName: name.0, lastName: name.1)
                // 프린트 자체는 동시 큐 에서 일어날수있도록(다만, 엄격한 Thread-safe는 아니다.)
                print("현재 이름(write-safe): \(writeSyncPerson.name)")
            }
        }
        writeSyncNameGroup.notify(qos: .unspecified, flags: [], queue: DispatchQueue.main) {
            print("마지막 이름은?(write-safe): \(writeSyncPerson.name)")
        }
    }
    
    // Thread-safe 하면서 print도 제대로 되는 경우의 함수 정의 -> 객체의 재설계
    func changeNameSafelyPrintRightly() {
        let threadSafeNameGroup = DispatchGroup()
        
        let threadSafePrintRightPerson = ThreadSafePrintRightPerson(firstName: "길동", lastName: "강")
        
        // 동시 작업으로 진행
        for(idx, name) in nameList.enumerated() {
            concurrentQueue.async(group: threadSafeNameGroup, qos: .unspecified, flags: []) {
                usleep(UInt32(10_000 * idx))
                threadSafePrintRightPerson.changeName(firstName: name.0, lastName: name.1)
            }
        }
        threadSafeNameGroup.notify(qos: .unspecified, flags: [], queue: DispatchQueue.main) {
            print("마지막 이름은?(Thread-safe): \(threadSafePrintRightPerson.name)")
        }
    }
}

