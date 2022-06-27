//
//  Feature.swift
//  FC_AppStore
//
//  Created by Morgan Kang on 2022/03/15.
//

import Foundation
import UIKit

struct Feature: Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}

