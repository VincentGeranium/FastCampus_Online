//
//  CovidDetailViewCell.swift
//  FC_COVID19
//
//  Created by Morgan Kang on 2022/01/26.
//

import UIKit

class CovidDetailViewCell: UITableViewCell {
    
    static let reuseIdentifier = "CovidDetailViewCell"
    
    var titleLabel: UILabel = {
        var label: UILabel = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    var contentsLabel: UILabel = {
        var label: UILabel = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        self.backgroundColor = .systemBlue
        
        setupTitleLabel()
        setupContentsLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupTitleLabel() {
        let guide = self.safeAreaLayoutGuide
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
        ])
        
    }
    
    func setupContentsLabel() {
        let guide = self.safeAreaLayoutGuide
        
        contentsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(contentsLabel)
        
        NSLayoutConstraint.activate([
            contentsLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            contentsLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            contentsLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            contentsLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
    


}
