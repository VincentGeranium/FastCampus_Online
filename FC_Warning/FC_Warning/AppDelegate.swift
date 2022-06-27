//
//  AppDelegate.swift
//  FC_Warning
//
//  Created by Morgan Kang on 2022/02/15.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        // Messaging Delegate 설정.
        Messaging.messaging().delegate = self
        
        // FCM의 현재 등록 토큰이나 갱신되는 시점을 알고 적절한 액션을 취할 수 있다.
            // FCM의 현재 등록된 토큰 확인
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error: FCM 토큰 가져오기 \(error.localizedDescription)")
            } else if let token = token {
                print("FCM 등록 토큰 : \(token)")
            }
        }
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, error in
            print("ERROR, Request Notifications Authorization: \(error.debugDescription) ")
        }
        
        application.registerForRemoteNotifications()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .sound, .badge, .banner])
    }
}

extension AppDelegate: MessagingDelegate {
    // 토큰이 갱신되는 시점은 Messaging Delegate를 통해 알 수 있다.
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken = fcmToken else { return }
        print("FCM 등록 토큰 갱신: \(fcmToken)")
    }
}
