//
//  BeerDetailViewController.swift
//  FC_Brewery
//
//  Created by Morgan Kang on 2022/02/23.
//

import Foundation
import UIKit
import Kingfisher

class BeerDetailViewController: UITableViewController {
    var beer: Beer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UINavigationBar
        title = beer?.name ?? "no name"
        
        // UITableView
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BeerDetailListCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        // Header
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        let headerView = UIImageView(frame: frame)
        let imageURL = URL(string: beer?.imageURL ?? "")
        
        headerView.contentMode = .scaleAspectFit
        headerView.kf.setImage(with: imageURL, placeholder: UIImage(named: "beer_icon"), options: nil, completionHandler: nil)
        
        // tableView header
        tableView.tableHeaderView = headerView
        
    }
}

// UITableView DataSource, Delegate 설정
extension BeerDetailViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return beer?.foodPairing?.count ?? 0
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "ID"
        case 1:
            return "Description"
        case 2:
            return "Brewers Tip"
        case 3:
            let isFoodPairingEmpty = beer?.foodPairing?.isEmpty ?? true
            return isFoodPairingEmpty ? nil : "Food Pairing"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "BeerDetailListCell")
        cell.selectionStyle = .none

        if #available(iOS 14, *) {
            var content = cell.defaultContentConfiguration()
            content.textProperties.numberOfLines = 0
            
            switch indexPath.section {
            case 0:
                content.text = String(describing: beer?.id ?? 0)
                cell.contentConfiguration = content
                return cell
            case 1:
                content.text = beer?.description ?? "no description"
                cell.contentConfiguration = content
                return cell
            case 2:
                content.text = beer?.brewersTips ?? "no brewers tips"
                cell.contentConfiguration = content
                return cell
            case 3:
                content.text = beer?.foodPairing?[indexPath.row] ?? ""
                cell.contentConfiguration = content
                return cell
            default:
                cell.contentConfiguration = content
                return cell
            }
        } else {
            cell.textLabel?.numberOfLines = 0
            switch indexPath.section {
            case 0:
                cell.textLabel?.text = String(describing: beer?.id ?? 0)
                return cell
            case 1:
                cell.textLabel?.text = beer?.description ?? "no description"
                return cell
            case 2:
                cell.textLabel?.text = beer?.brewersTips ?? "no brewers tips"
                return cell
            case 3:
                cell.textLabel?.text = beer?.foodPairing?[indexPath.row] ?? ""
                return cell
            default:
                return cell
            }
        }
    }
}
