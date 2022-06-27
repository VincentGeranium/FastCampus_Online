//
//  guide.swift
//  AutolayoutExample
//
//  Created by Morgan Kang on 2021/12/04.
//

import Foundation
import UIKit

public func layoutGuide(vc: UIViewController) -> UILayoutGuide {
    let guide = vc.view.safeAreaLayoutGuide
    return guide
}
