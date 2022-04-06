//
//  FeedViewController.swift
//  instagramClone
//
//  Created by Kwangjun Kim on 2022/04/06.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
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
}
