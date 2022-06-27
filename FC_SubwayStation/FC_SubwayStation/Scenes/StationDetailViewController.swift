//
//  StationDetailViewController.swift
//  FC_SubwayStation
//
//  Created by Morgan Kang on 2022/03/19.
//

import Alamofire
import UIKit
import SnapKit

final class StationDetailViewController: UIViewController {
    private let station: Station
    
    private var realtimeArrivalList: [StationArrivalDataResponseModel.RealTimeArrival] = []
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FetchData), for: .valueChanged)
        
        return refreshControl
    }()
    
    @objc func FetchData() {
        var stationName = station.stationName
        
        stationName = stationName.replacingOccurrences(of: "역", with: "")
        
        let urlString = "http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/\(stationName)"
        
        guard let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        AF.request(url).responseDecodable(of: StationArrivalDataResponseModel.self) { [weak self] response in
            self?.refreshControl.endRefreshing()
            
            switch response.result {
            case .success(let data):
                self?.realtimeArrivalList = data.realtimeArrivalList
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
        .resume()
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(
            width: self.view.frame.width - 32.0,
            height: 100.0
        )
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(StationDetailCollectionViewCell.self, forCellWithReuseIdentifier: StationDetailCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        
        return collectionView
    }()
    
    init(station: Station) {
        self.station = station
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = station.stationName
        
        setupViews()
        
        FetchData()
    }
    
    func setupViews() {
        self.view.addSubview(self.collectionView)
        
        setupLayout()
    }
}

private extension StationDetailViewController {
    private func setupLayout() {
        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension StationDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realtimeArrivalList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StationDetailCollectionViewCell.reuseIdentifier, for: indexPath) as? StationDetailCollectionViewCell else { return UICollectionViewCell()
        }
        
        let realtimeArrival = realtimeArrivalList[indexPath.row]
        
        cell.setup(with: realtimeArrival)
        
        return cell
    }
}
