//
//  AppDelegate.swift
//  FC_CreditCardList
//
//  Created by Morgan Kang on 2022/02/07.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        // db 선언
        let db = Firestore.firestore()
        
        // db에 컬렉션 생성 -> creditCardList라는 이름의 컬렉션 이름
            // getDocuments를 통해 db의 snapshot를 가져올 수 있다.
                // 이렇게 하는 이유는 내가 보고자 하는 DB에 데이터가 없을 때만 초기 데이터를 한 번에 넣어 줄 것이므로 DB를 확인하려면 getDocuments를 통해 snapshot을 통해 바라봐야 한다. (값이 있는지 없는지 확인하기 위해.)
        db.collection("creditCardList").getDocuments { snapshot, error in
            // 때문에 snapshot이 비어져 있는지 확인
                // 비어져있지 않다면 return
            guard snapshot?.isEmpty == true else { return }
            // 아무것도 없다면 DB가 비어있다는 뜻이므로 batch를 생성.
            let batch = db.batch()
            
            // batch 안에 하나씩 객체를 넣을 수 있도록 경로(파일 경로 -> reference)를 만들어준다.
                // creditCardList라는 컬렉션에 card0라는 경로를 만들어주었다.
            let card0Ref = db.collection("creditCardList").document("card0")
            let card1Ref = db.collection("creditCardList").document("card1")
            let card2Ref = db.collection("creditCardList").document("card2")
            let card3Ref = db.collection("creditCardList").document("card3")
            let card4Ref = db.collection("creditCardList").document("card4")
            let card5Ref = db.collection("creditCardList").document("card5")
            let card6Ref = db.collection("creditCardList").document("card6")
            let card7Ref = db.collection("creditCardList").document("card7")
            let card8Ref = db.collection("creditCardList").document("card8")
            let card9Ref = db.collection("creditCardList").document("card9")
            
            // 이 더미에 있는 아이들을 각각의 경로에 갈 수 있도록 batch에 넣어준다.
                // batch에 넣는 setData 함수가 throw 함수이므로 do-try-catch문으로 작성
            do {
                // batch에 data를 set하는 함수를 넣어준다.
                    // setData의 첫 번째 파라미터에는 Codable이 가능한 데이터를 넣어준다, 두 번째 파라미터에는 데이터를 넣어줄 경로를 넘겨준다.
                try batch.setData(from: CreditCardDummy.card0, forDocument: card0Ref)
                try batch.setData(from: CreditCardDummy.card1, forDocument: card1Ref)
                try batch.setData(from: CreditCardDummy.card2, forDocument: card2Ref)
                try batch.setData(from: CreditCardDummy.card3, forDocument: card3Ref)
                try batch.setData(from: CreditCardDummy.card4, forDocument: card4Ref)
                try batch.setData(from: CreditCardDummy.card5, forDocument: card5Ref)
                try batch.setData(from: CreditCardDummy.card6, forDocument: card6Ref)
                try batch.setData(from: CreditCardDummy.card7, forDocument: card7Ref)
                try batch.setData(from: CreditCardDummy.card8, forDocument: card8Ref)
                try batch.setData(from: CreditCardDummy.card9, forDocument: card9Ref)
            } catch let error {
                print("Error writing card to Firestore \(error.localizedDescription)")
            }
            // batch를 commit해준다.
                // 반드시 batch를 commit을 해주어야 데이터가 추가가 된다
            batch.commit()
        }
        
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

