//
//  ChartView.swift
//  FC_COVID19
//
//  Created by Morgan Kang on 2022/01/26.
//

import Foundation
import Charts

class ChartView: PieChartView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
