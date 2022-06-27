//
//  ViewController.swift
//  QuotesGenerator
//
//  Created by Morgan Kang on 2021/12/09.
//

import UIKit

class ViewController: UIViewController {
    
    let quotes = [
        Quotes(contents: "인내는 어떤 실력보다 강하다.", name: "Ban Hogan"),
        Quotes(contents: "오랫동안 꿈을 그리는 사람은 마침내 그 꿈을 닮아간다.", name: "Friedrich Wilhelm Nietzsche"),
        Quotes(contents: "작은 성공부터 시작하라. 성공에 익숙해지면 무슨 목표든지 할 수 있다는 자신감이 생긴다.", name: "Dale Carnegie"),
        Quotes(contents: "나의 미래는 내가 오늘 무엇을 하느냐에 따라 달려있다.", name: "Mohandas Karamchand Gandhi"),
        Quotes(contents: "마음이 현실을 만들어 낸다. 우리는 마음을 바꿈으로써 현실을 바꿀 수 있다.", name: "Plato"),
        Quotes(contents: "기회는 누구에게나 있다. 다만 포착하지 못할 뿐이다.", name: "Andrew Carnegie"),
        Quotes(contents: "시작하는 데 있어서 나쁜 시기란 없다.", name: "Franz Kafka"),
        Quotes(contents: "너에게 있어서 가장 불편한 시기는 너 자신을 가장 많이 배우는 시기이다.", name: "Mary Louise Bean"),
    ]
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "명언 생성기."
        label.font = UIFont(name: "System", size: 17.0)
        label.textAlignment = .center
        return label
    }()
    
    let mainView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    var quotesLabel: UILabel = {
        var quotesLabel: UILabel = UILabel()
        quotesLabel.text = "quotesLabel"
        quotesLabel.textAlignment = .center
        quotesLabel.numberOfLines = 0
        quotesLabel.backgroundColor = .systemBlue
        quotesLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        quotesLabel.setContentCompressionResistancePriority(.init(rawValue: 250), for: .vertical)
        return quotesLabel
    }()
    
    var nameLabel: UILabel = {
        var nameLabel: UILabel = UILabel()
        nameLabel.text = "nameLabel"
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nameLabel.backgroundColor = .systemGray
        nameLabel.setContentHuggingPriority(.init(rawValue: 251), for: .vertical)
        nameLabel.setContentCompressionResistancePriority(.init(rawValue: 1000), for: .vertical)
        return nameLabel
    }()
    
    let createButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("명언 생성", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupTitleLabel()
        setupMainView()
        setupQuotesLabel()
        setupNameLabel()
        setupCreateButton()
    }
    
    private func guide() -> UILayoutGuide {
        let guide = self.view.safeAreaLayoutGuide
        return guide
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: guide().topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: guide().leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: guide().trailingAnchor, constant: -24),
        ])
    }
    
    private func customBackgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    private func setupMainView() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mainView)
        
        mainView.backgroundColor = customBackgroundColor(red: 230, green: 230, blue: 230)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            mainView.leadingAnchor.constraint(equalTo: guide().leadingAnchor, constant: 24),
            mainView.trailingAnchor.constraint(equalTo: guide().trailingAnchor, constant: -24),
            mainView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func setupQuotesLabel() {
        quotesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.mainView.addSubview(quotesLabel)
        
        NSLayoutConstraint.activate([
            quotesLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            quotesLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            quotesLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.mainView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: quotesLabel.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            nameLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
        ])
    }
    
    private func setupCreateButton() {
        createButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(createButton)
        
        NSLayoutConstraint.activate([
            createButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            createButton.topAnchor.constraint(equalTo: mainView
                                                .bottomAnchor, constant: 20),
        ])
        
        self.createButton.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
    }
    
    @objc private func didTapCreateButton() {
        //arc4random_uniform(5) -> 0~4 사이의 난수를 생성하는 코드.
        let randomNumber = Int(arc4random_uniform(7))
        
        let quotes = self.quotes[randomNumber]
        
        self.quotesLabel.text = quotes.contents
        self.nameLabel.text = quotes.name
    }
}

