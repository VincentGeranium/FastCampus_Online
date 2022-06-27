//
//  MainStackView.swift
//  FC_Spotify
//
//  Created by Morgan Kang on 2022/01/30.
//

import UIKit

class MainStackView: UIStackView {
    
    let mainImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "music.note.house.fill")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let mainLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 3
        label.text =
        """
        내 마음에 꼭 드는 또 다른
        플레이리스트를
        발견해보세요.
        """
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 31, weight: .bold)
        label.textAlignment = .center
//        label.insetsLayoutMarginsFromSafeArea = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.alignment = .center
        self.distribution = .fill
        self.spacing = 0
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        setupMainImageView()
        setupMainLabel()
    }
    
    private func setupMainImageView() {
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(mainImageView)
        
        NSLayoutConstraint.activate([
            mainImageView.widthAnchor.constraint(equalToConstant: 70),
            mainImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupMainLabel() {
        let guide = self.safeAreaLayoutGuide
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(mainLabel)
        /*
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor),
            mainLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            mainLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            mainLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
         */
    }

}
