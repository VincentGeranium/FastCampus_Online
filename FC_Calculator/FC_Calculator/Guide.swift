//
//  Guide.swift
//  FC_Calculator
//
//  Created by Morgan Kang on 2021/12/31.
//

import Foundation
import UIKit

enum ViewControllerError: String, Error {
    case CantGetViewController = "Can't get ViewController"
}

struct Guide {
    func guide(vc: UIViewController) -> UILayoutGuide {
        return vc.view.safeAreaLayoutGuide
    }
}
