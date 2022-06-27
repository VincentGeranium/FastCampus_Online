//
//  StationSearchViewController.swift
//  FC_SubwayStation
//
//  Created by Morgan Kang on 2022/03/17.
//

import Alamofire
import SnapKit
import UIKit

class StationSearchViewController: UIViewController {
    private var stations: [Station] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        setNavigationItems()
        setTableViewLayout()
    }
    
    private func setNavigationItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "지하철 역을 입력해주세요."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    private func setTableViewLayout() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func requestStationName(from stationName: String) {
        let urlString = "http://openapi.seoul.go.kr:8088/sample/json/SearchInfoBySubwayNameService/1/5/\(stationName)"
        
        guard let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        AF.request(url).responseDecodable(of: StationResponseModel.self) { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.stations = data.stations
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
                print(data.stations)
            case .failure(let error):
                print(error)
            }
        }
        .resume()
    }
}

extension StationSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        self.tableView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.tableView.isHidden = true
        stations = []
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        requestStationName(from: searchText)
    }
}

extension StationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = stations[indexPath.row]
        
        let vc = StationDetailViewController(station: station)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension StationSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let station = stations[indexPath.row]
        
        if #available(iOS 14.5, *) {
            var content = cell.defaultContentConfiguration()
            content.text = station.stationName
            content.secondaryText = station.lineNumber
            
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = station.stationName
            cell.detailTextLabel?.text = station.lineNumber
        }
        return cell
    }
}
