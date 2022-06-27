//
//  ViewController.swift
//  FC_Notice
//
//  Created by Morgan Kang on 2022/02/11.
//

import UIKit
import FirebaseRemoteConfig
import FirebaseAnalytics

class ViewController: UIViewController {
    
    // remote config 선언
    var remoteConfig: RemoteConfig?

    override func viewDidLoad() {
        super.viewDidLoad()

        // remote config 객체 정의
            // RemoteConfig 선언.
        remoteConfig = RemoteConfig.remoteConfig()
        
        // RemoteConfigSettings 선언
        let setting = RemoteConfigSettings()
        // minimumFetchInterval = 0 이란 -> 테스트를 위해서 새로운 값을 fetch하는 인터벌을 최소화하여 최대한 자주 원격 구성에 있는 데이터들을 가져올 수 있게 해놓는 것이다.
        setting.minimumFetchInterval = 0
        
        // 설정한 값을 생성한 Remote config 객체에 setting 값으로 두게 구현.
        remoteConfig?.configSettings = setting
        
        // Remote config 객체의 기본값 구성.
        // RemoteConfigDefault.plist에서 설정한 값을 Remote Config가 인식할 수 있도록 연결 -> setDefault() 메소드 사용.
        remoteConfig?.setDefaults(fromPlist: "RemoteConfigDefaults")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNotice()
    }
}

extension ViewController {
    func getNotice() {
        guard let remoteConfig = remoteConfig else { return }
        
        remoteConfig.fetch { [weak self] remoteConfigFetchStatus, _ in
            if remoteConfigFetchStatus == .success {
                // 만약 값을 성공적으로 가져 왔을 경우
                remoteConfig.activate(completion: nil)
            } else {
                print("ERROR: config not fetched")
            }
            
            guard let self = self else { return }
            
            if !self.isNoticeHidden(remoteConfig) {
                let noticeVC = NoticeViewController()
//                noticeVC.modalPresentationStyle = .custom
//                noticeVC.modalTransitionStyle = .crossDissolve
                
                // firebase console에서 여러줄의 string을 넣기 위해서는 \n 을 사용하는데 fetching을 하는 과정에서는 \\n으로 역슬래시가 두 번 들어온다. 때문에 swift에서 줄바꿈을 인식을 하지 못한다 그래서 사용시 replacingOccurrences로 \\n을 \n으로 바꿔줘야 한다.
                //c.f _ .replacingOccurrences(of: "\\n", with: "\n") 는. \\n을 \n으로 바꾸어주는 역활을 한다.
                let title = (remoteConfig["title"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let detail = (remoteConfig["detail"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let date = (remoteConfig["date"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                
                // NoticeViewController에 미리 선언한 튜플에 각각에 맞는 값을 설정해준다.
                noticeVC.noticeContents = (title: title, detail: detail, date: date)
                
                self.present(noticeVC, animated: true, completion: nil)
            } else {
                self.showEventAlert()
            }
        }
    }
    
    func isNoticeHidden(_ remoteConfig: RemoteConfig) -> Bool {
        // Remote Config 중 "isHidden" key값의 bool 타입의 value를 가져오게 구현.
        return remoteConfig["isHidden"].boolValue
    }
}

// MARK: - A/B Testing
    // A/B Testing을 위한 Extension
extension ViewController {
    func showEventAlert() {
        guard let remoteConfig = remoteConfig else { return }
        
        remoteConfig.fetch { [weak self] status, error in
            if status == .success {
                debugPrint("🙋‍♂️ Success to fetch")
                remoteConfig.activate(completion: nil)
            } else {
                debugPrint("🙋‍♂️Config not fetched")
                print("Config not fetched : \(String(describing: error))")
            }
            
            let message = remoteConfig["message"].stringValue ?? ""
//            let message = remoteConfig["message"].stringValue ?? ""
            debugPrint("🙋‍♂️\(message)")
            
            let confirmAction = UIAlertAction(title: "확인하기", style: .default) { _Arg in
                // Google Analytics
                    // 실제 확인 버튼이 눌렸을 때 Event logging 구현
                Analytics.logEvent("promotion_alert", parameters: nil)
                
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            let alertController = UIAlertController(title: "깜짝 이벤트", message: message, preferredStyle: .alert)
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}
