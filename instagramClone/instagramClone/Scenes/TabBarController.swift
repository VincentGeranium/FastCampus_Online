//
//  TabBarController.swift
//  instagramClone
//
//  Created by Kwangjun Kim on 2022/04/06.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [setupFeedViewController(), setupProfileViewController()]
    }
}

extension TabBarController {
    func setupFeedViewController() -> UINavigationController {
        
        let rootViewController: FeedViewController = {
            let viewController = FeedViewController()
            viewController.tabBarItem = UITabBarItem(
                title: nil,
                image: UIImage(systemName: "house"),
                selectedImage: UIImage(systemName: "house.fill")
            )
            return viewController
        }()
        
        let feedViewController = UINavigationController(rootViewController: rootViewController)
        
        return feedViewController
    }
    
    func setupProfileViewController() -> UINavigationController {
        let rootViewController: ProfileViewController = {
            let viewController = ProfileViewController()
            viewController.tabBarItem = UITabBarItem(
                title: nil,
                image: UIImage(systemName: "person"),
                selectedImage: UIImage(systemName: "person.fill")
            )
            return viewController
        }()
        
        let profileViewController = UINavigationController(rootViewController: rootViewController)
        
        return profileViewController
    }
}
