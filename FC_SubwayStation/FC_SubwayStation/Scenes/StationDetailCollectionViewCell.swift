//
//  StationDetailCollectionViewCell.swift
//  FC_SubwayStation
//
//  Created by Morgan Kang on 2022/03/19.
//

import UIKit
import SnapKit

final class StationDetailCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier: String = "StationDetailCollectionViewCell"
    
    private lazy var lineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        
        return label
    }()
    
    private lazy var remainTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        
        return label
    }()
    
    func  setup(with realtimeArrival: StationArrivalDataResponseModel.RealTimeArrival) {
        setupCellLayer()
        
        self.backgroundColor = .systemBackground
        
        [lineLabel, remainTimeLabel].forEach { self.addSubview($0) }
        
        lineLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(16.0)
        }
        
        remainTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(lineLabel)
            $0.top.equalTo(lineLabel.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview().inset(16.0)
        }
        
        lineLabel.text = realtimeArrival.line
        remainTimeLabel.text = realtimeArrival.remainTime
    }
    
    private func setupCellLayer() {
        self.layer.cornerRadius = 12.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 10.0
    }
}
