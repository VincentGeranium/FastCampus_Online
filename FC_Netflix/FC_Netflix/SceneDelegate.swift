//
//  SceneDelegate.swift
//  FC_Netflix
//
//  Created by Morgan Kang on 2022/02/17.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // SwiftUI 코드
        let contentView = ContentView()
        
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = UIHostingController(rootView: contentView)
        self.window?.makeKeyAndVisible()
        
        // 기존 코드
        /*
         guard let windowScene = scene as? UIWindowScene else { return }
         self.window = UIWindow(windowScene: windowScene)
        // layout 설정
            // CollectionView의 경우 FlowLaout이 있어야만 생성이 되기 때문에 기본으로 설정해주어야 한다.
        let layout = UICollectionViewFlowLayout()
        
        // homeViewController 설정
            // HomeViewController는 CollectionViewController이기 때문에 FlowLayout을 넣어줘야 생성이 된다.
        let homeViewController = HomeViewController(collectionViewLayout: layout)
        
        // rootNavigationController 설정
            // homeViewController를 rootNavigationController의 rootViewController로 갖는다.
        let rootNavigationController = UINavigationController(rootViewController: homeViewController)
        
        // window의 rootViewController 설정
            // rootNavigationController를 window의 rootViewController로 얹어준다.
        self.window?.rootViewController = rootNavigationController
        
        // 이 코드를 구현해야 지금까지 설정한 코드들이 실제로 보여지게 된다.
        self.window?.makeKeyAndVisible()
        */
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

