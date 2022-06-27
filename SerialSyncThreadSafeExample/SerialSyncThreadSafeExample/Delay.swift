//
//  Delay.swift
//  SerialSyncThreadSafeExample
//
//  Created by Morgan Kang on 2021/12/19.
//

import Foundation

func randomDelay(maxDuration: Double) {
    let randomWait = arc4random_uniform(UInt32(maxDuration * Double(USEC_PER_SEC)))
    usleep(randomWait)
}
