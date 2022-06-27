//
//  SettingBarButtonItem.swift
//  LEDBoard
//
//  Created by Morgan Kang on 2021/12/21.
//

import Foundation
import UIKit

func settingBarButtonItem(target: AnyObject, action: Selector) -> UIBarButtonItem {
    return UIBarButtonItem(title: "설정", style: .plain, target: target, action: action)
}
