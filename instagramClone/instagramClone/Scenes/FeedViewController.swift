//
//  FeedViewController.swift
//  instagramClone
//
//  Created by Kwangjun Kim on 2022/04/06.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.reuseIdentifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseIdentifier, for: indexPath) as? FeedTableViewCell else {
            return FeedTableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.setup()
        
        return cell
    }
}

extension FeedViewController {
    func setupNavigationBar() {
        self.navigationItem.title = "Instagram"
        
        let uploadButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.app"),
            style: .plain,
            target: self,
            action: nil
        )
        
        navigationItem.rightBarButtonItem = uploadButton
    }
    
    func setupTableView() {
        self.view.addSubview(tableView)
        
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
