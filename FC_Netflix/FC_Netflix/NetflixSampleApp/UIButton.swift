//
//  UIButton.swift
//  FC_Netflix
//
//  Created by Morgan Kang on 2022/02/20.
//

import Foundation
import UIKit

extension UIButton {
    func adjustVerticalLayout(_ spacing: CGFloat = 0) {
        let imageSize = self.imageView?.frame.size ?? .zero
        let titleLabelSize = self.titleLabel?.frame.size ?? .zero
        
        if #available (iOS 15.0, *) {
            print("iOS 15.0 버전을 위한 코드 구현 필요.")
        } else {
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleLabelSize.height + spacing), left: 0, bottom: 0, right: -titleLabelSize.width)
        }
    }
}
