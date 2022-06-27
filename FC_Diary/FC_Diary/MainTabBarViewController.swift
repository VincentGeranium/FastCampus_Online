//
//  MainTabBarViewController.swift
//  FC_Diary
//
//  Created by Morgan Kang on 2022/01/10.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    let diaryViewNaviController = UINavigationController(rootViewController: DiaryViewController())
    let bookMarkNavieController = UINavigationController(rootViewController: BookMarkViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.viewControllers = [diaryViewNaviController, bookMarkNavieController]
        
        configureDiaryViewNaviController()
        configureBookMarkViewNaviController()
    }
    
    func configureDiaryViewNaviController() {
        guard let defaultImage = UIImage(systemName: "folder") else { return }
        guard let selectImage = UIImage(systemName: "folder.fill") else { return }
        
        self.diaryViewNaviController.tabBarItem = .init(title: "일기장", image: defaultImage, selectedImage: selectImage)
        
    }
    
    func configureBookMarkViewNaviController() {
        guard let defaultImage = UIImage(systemName: "star") else { return }
        guard let selectImage = UIImage(systemName: "star.fill") else { return }
        
        self.bookMarkNavieController.tabBarItem = .init(title: "즐겨찾기", image: defaultImage, selectedImage: selectImage)
    }
}
