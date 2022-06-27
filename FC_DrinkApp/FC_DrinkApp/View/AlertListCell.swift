//
//  AlertListCell.swift
//  FC_DrinkApp
//
//  Created by Morgan Kang on 2022/02/13.
//

import UIKit
import UserNotifications

class AlertListCell: UITableViewCell {
    static let reuseIdentifier: String = "AlertListCell"
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    let meridiemLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "오전"
        label.font = UIFont.systemFont(ofSize: 28, weight: .light)
        
        return label
    }()
    
    let timeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "00:00"
        label.font = UIFont.systemFont(ofSize: 50, weight: .light)
        
        return label
    }()
    
    let alertSwitch: UISwitch = {
        let alertSwitch: UISwitch = UISwitch()
        alertSwitch.addTarget(self, action: #selector(alertSwitchValueChanger(_:)), for: .valueChanged)
        return alertSwitch
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        configureMeridiemLabel()
        configureTimeLabel()
        configureAlertSwitch()
    }
    
    private func configureMeridiemLabel() {
        meridiemLabel.translatesAutoresizingMaskIntoConstraints = false
        let guide = self.safeAreaLayoutGuide
        self.addSubview(meridiemLabel)
        NSLayoutConstraint.activate([
            meridiemLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20)
        ])
    }
    
    private func configureTimeLabel() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        let guide = self.safeAreaLayoutGuide
        self.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: self.meridiemLabel.trailingAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: meridiemLabel.bottomAnchor, constant: 8),
        ])
    }
    
    private func configureAlertSwitch() {
        alertSwitch.translatesAutoresizingMaskIntoConstraints = false
        let guide = self.safeAreaLayoutGuide
        self.addSubview(alertSwitch)
        NSLayoutConstraint.activate([
            alertSwitch.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            alertSwitch.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
        ])
    }
    
    @objc func alertSwitchValueChanger(_ sender: UISwitch) {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              var alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else { return }
        
        alerts[sender.tag].isOn = sender.isOn
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alerts), forKey: "alerts")
        
        // 스위치가 처음에는 on 상태이라 해당되지 않지만 스위치를 껏다가 다시 켠 경우에는 다시 notificationCenter에 추가를 해주어야 한다.
        if sender.isOn {
            userNotificationCenter.addNotificationRequest(by: alerts[sender.tag])
        } else {
            // 스위치가 off인 상태인 경우 알림 삭제
            userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [alerts[sender.tag].id])
        }
    }

}
