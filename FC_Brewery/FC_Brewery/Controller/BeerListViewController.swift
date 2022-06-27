//
//  BeerListViewController.swift
//  FC_Brewery
//
//  Created by Morgan Kang on 2022/02/23.
//

import Foundation
import UIKit

class BeerListViewController: UITableViewController {
    // Beer 배열 선언
    var beerList: [Beer] = []
    
    // page 선언
    var currentPage = 1
    
    // data task 배열 선언
    var dataTasks: [URLSessionTask] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // UINavigationBar
        title = "브루어리 앱"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // UITableView 설정.
        tableView.register(BeerListCell.self, forCellReuseIdentifier: BeerListCell.reuseIdentifier)
        tableView.rowHeight = 150
        
        fetchBeer(of: currentPage)
        
        // prefetchDataSource 설정
        tableView.prefetchDataSource = self
    }
}

// DataSource, Delegate
extension BeerListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerListCell.reuseIdentifier, for: indexPath) as? BeerListCell else { return UITableViewCell() }
        
        let beer = beerList[indexPath.row]
        cell.configure(with: beer)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBeer = beerList[indexPath.row]
        let detailViewController = BeerDetailViewController()
        
        detailViewController.beer = selectedBeer
        self.show(detailViewController, sender: nil)
    }
}
/*
// 강의 코드
private extension BeerListViewController {
    func fetchBeer(of page: Int) {
        
        // URL
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)") else { return }
        
        // Data task 배열 속 url 이 있는지 확인
        guard dataTasks.firstIndex(where: { $0.originalRequest?.url == url }) == nil else { return }
        
        // Request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Data Task
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil else { return }
            guard let self = self else { return }
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse else { return }
            guard let beers = try? JSONDecoder().decode([Beer].self, from: data) else { return }
            
            switch response.statusCode {
            case (200...299): // 성공
                self.beerList += beers
                self.currentPage += 1
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case (400...499): // 클라이언트 에러
                print("""
                ERROR: Client ERROR \(response.statusCode)
                Response: \(response)
                """)
            case (500...599): // 서버 에러
                print("""
                ERROR: Sever ERROR \(response.statusCode)
                Response: \(response)
                """)
            default:
                print("""
                ERROR: \(response.statusCode)
                Response: \(response)
                """)
            }
        }
        dataTask.resume()
        dataTasks.append(dataTask)
    }
}
*/

// 내 코드
private extension BeerListViewController {
    func fetchBeer(of page: Int) {
        // urlSession
        let urlSession = URLSession(configuration: .default)
        
        // URL
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)") else { return }
        
        // Data task 배열 속 url 이 있는지 확인
        guard dataTasks.firstIndex(where: { $0.originalRequest?.url == url }) == nil else { return }
        
        // Request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Data Task
            // URLSession의 shared -> singleton 패턴 사용하지 않고 URLSession의 기본 세션으로 설정하여 URLSessionConfiguration 객체 사용?
        let dataTask = urlSession.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil else { return }
            guard let self = self else { return }
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse else { return }
            guard let beers = try? JSONDecoder().decode([Beer].self, from: data) else { return }
            
            switch response.statusCode {
            case (200...299): // 성공
                self.beerList += beers
                self.currentPage += 1
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case (400...499): // 클라이언트 에러
                print("""
                ERROR: Client ERROR \(response.statusCode)
                Response: \(response)
                """)
            case (500...599): // 서버 에러
                print("""
                ERROR: Sever ERROR \(response.statusCode)
                Response: \(response)
                """)
            default:
                print("""
                ERROR: \(response.statusCode)
                Response: \(response)
                """)
            }
        }
        dataTask.resume()
        dataTasks.append(dataTask)
    }
}


// UITableViewDataSourcePrefeting
extension BeerListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard currentPage != 1 else { return }
        
        indexPaths.forEach {
            if ($0.row + 1) / 25 + 1 == currentPage {
                self.fetchBeer(of: currentPage)
            }
        }
    }
}
