//
//  CovidDetailViewController.swift
//  FC_COVID19
//
//  Created by Morgan Kang on 2022/01/29.
//

import UIKit

class CovidDetailViewController: UIViewController {
    
    var covidDetailView: CovidDetailView = {
        let tableView: CovidDetailView = CovidDetailView()

        return tableView
    }()
    
    var covidOverview: CovidOverview?
    
    var newCase: String?
    var totalCase: String?
    var recoverd: String?
    var death: String?
    var percentage: String?
    var newFcase: String?
    var newCcaas: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        setupCovidDetailView()
        configureView()
    }
    
    func configureView()  {
        guard let covidOverview = covidOverview else {
            return
        }
        self.title = covidOverview.countryName
        self.newCase = covidOverview.newCase
        self.totalCase = covidOverview.totalCase
        self.recoverd = covidOverview.recovered
        self.death = covidOverview.death
        self.percentage = covidOverview.percentage
        self.newFcase = covidOverview.newFcase
        self.newCcaas = covidOverview.newCcase
    }
    
    func configureTableView() {
        self.covidDetailView.delegate = self
        self.covidDetailView.dataSource = self
        self.covidDetailView.register(CovidDetailViewCell.self, forCellReuseIdentifier: CovidDetailViewCell.reuseIdentifier)
        self.covidDetailView.tableFooterView = UIView()

    }
    
    func setupCovidDetailView() {
        let guide = self.view.safeAreaLayoutGuide
        
        covidDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(covidDetailView)
        
        NSLayoutConstraint.activate([
            covidDetailView.topAnchor.constraint(equalTo: guide.topAnchor),
            covidDetailView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            covidDetailView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            covidDetailView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }

}

extension CovidDetailViewController: UITableViewDelegate {
    
}

extension CovidDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CovidDetailViewCell.reuseIdentifier, for: indexPath) as? CovidDetailViewCell else { return UITableViewCell() }
        
        
            switch indexPath.row {
            case 0:
                cell.titleLabel.text = "신규 확진자"
                cell.contentsLabel.text = self.newCase
            case 1:
                cell.titleLabel.text = "확진자"
                cell.contentsLabel.text = self.newCase
            case 2:
                cell.titleLabel.text = "완치자"
                cell.contentsLabel.text = self.recoverd
            case 3:
                cell.titleLabel.text = "사망자"
                cell.contentsLabel.text = self.death
            case 4:
                cell.titleLabel.text = "발생률"
                cell.contentsLabel.text = self.percentage
            case 5:
                cell.titleLabel.text = "해외유입 신규 확진자"
                cell.contentsLabel.text = self.newFcase
            case 6:
                cell.titleLabel.text = "지역발생 신규 확진자"
                cell.contentsLabel.text = self.newCcaas
            default:
                break
            }
        

    
        
        return cell
    }
    
    
}
