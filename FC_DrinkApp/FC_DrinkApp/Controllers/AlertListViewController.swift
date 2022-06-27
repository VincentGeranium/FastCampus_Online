//
//  AlertListViewController.swift
//  FC_DrinkApp
//
//  Created by Morgan Kang on 2022/02/13.
//

import UIKit
import UserNotifications

class AlertListViewController: UITableViewController {
    // tableView에 뿌려질 Alert 객체 배열 선언
    var alerts: [Alert] = []
    
    // userNotificationCenter 선언
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override init(style: UITableView.Style) {
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 이렇게 넣어주면 UserDefaults에 저장된 값대로 alerts가 반영될 것이다.
        alerts = alertList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "물마시기"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = .init(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addAlertButtonAction(_:)))
        self.tableView.register(AlertListCell.self, forCellReuseIdentifier: AlertListCell.reuseIdentifier)
    }
    
    // 새로운 alert가 추가되는 함수.
    @objc func addAlertButtonAction(_ sender: UIBarButtonItem) {
        let addAlertVC = AddAlertViewController()
        // 자식 뷰로 전달 될 데이터 핸들링
            // 생성된 알람을 리스트에 표현되도록 클로저 구현
                // c.f _ pickedDate는 클로저이다
        addAlertVC.pickedDate = {[weak self] date in
            guard let self = self else { return }
            
            // 현재 UserDefaults에서 가져온 값
            var alertList = self.alertList()
            // 자식뷰에서 date로 설정된 alert 값
                // switch는 항상 처음 추가시 켜져있어야 하므로 true
                // newAlert를 부모 뷰에 전달 -> userDefault로 먼저 값을 저장하는 것을 설정해야함.
                    // 각 셀 별로 설정된 스위치의 켜짐, 꺼짐 상태를 테이블 뷰가 알고 있어야 한다.
                        // 하지만 수시로 알림이 추가되고 또 추가 된 뒤에 시간 순서대로 정렬되어야 한다. 또 셀 삭제등 매우 다이나믹하게 상태가 변경되는 리스트에서 각 셀별의 상태를 확인할 수 있는 방법은 여러가지가 있다.
                            // 이 프로젝트에서는 그 여러가지 방법 중 userDefaults와 tag 기능을 이용하여 구현할 것이다. -> 각각의 값들을 서로 전달 할 것이다.
            let newAlert = Alert(date: date, isOn: true)
            
            alertList.append(newAlert)
            // 시간이 이른 순서대로 정렬
            alertList.sorted { $0.date < $1.date }
            self.alerts = alertList
            
            // UserDefaults Set, Encoding
                // 새로운 alerts가 추가 될 때마가 UserDefaaults에 반영이 되고 그러한 UserDefaults를 바라보고 있는 tableView도 똑같이 최신 상태로 보여줄 것이다.
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alerts), forKey: "alerts")
            
            // Notificaiton을 추가하는 함수
                // 새로 물마시기 하는 alert이 UserNotifiaction에도 저장이 된다.
            self.userNotificationCenter.addNotificationRequest(by: newAlert)
            
            self.tableView.reloadData()
        }
        self.present(addAlertVC, animated: true, completion: nil)
    }
    
    func alertList() -> [Alert] {
        // data는 property list 형식으로 내뱉는다. 따라서 PropertyListDecoder로 decode 해주어야 한다.
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              let alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else { return []}
        return alerts
    }
}

// UITableView DateSource, Delegate
extension AlertListViewController {
    // row의 갯수 정하기
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
    }
    
    // 섹션을 나누어서 구성
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "🚰물마실 시간"
        default:
            return nil
        }
    }
    
    // 셀 설정과 셀 컴포넌트 설정.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlertListCell.reuseIdentifier, for: indexPath) as? AlertListCell else { return UITableViewCell() }
        
        // 처음에 알람이 만들어지면 무조건 켜진 상태로 만들어지게 만들어지게 구현.
        cell.alertSwitch.isOn = alerts[indexPath.row].isOn
        // timeLabel에 어떤 시간을 표시 할 것인지 구현.
        cell.timeLabel.text = alerts[indexPath.row].time
        // 오전, 오후는 어떻게 표현 할 것인지 구현.
        cell.meridiemLabel.text = alerts[indexPath.row].meridiem
        
        // cell 자신의 index를 알기 위해 tag 값을 부여
        cell.alertSwitch.tag  = indexPath.row
        
        return cell
    }
    
    // 셀의 높이 설정
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // 추후에 알림을 삭제하거나 셀을 삭제할 때는 알람 전체를 삭제될 수 있도록 액션추가. -> delegate 메소드 추가
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            // 알림 삭제
            userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [alerts[indexPath.row].id])

            // 노티피케이션 삭제 구현.
            // c.f _ self.alerts -> 테이블 뷰가 바라보고있는 배열
            self.alerts.remove(at: indexPath.row)
            // UserDefaults에서도 삭제 -> 삭제된 배열을 반영
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alerts), forKey: "alerts")
            
            self.tableView.reloadData()
            return
        default:
            break
        }
    }
}

