//
//  AddAlertViewController.swift
//  FC_DrinkApp
//
//  Created by Morgan Kang on 2022/02/13.
//

import UIKit

class AddAlertViewController: UIViewController {
    // 부모 뷰로 datePicker로 부터 선택된 시간 데이터를 전달하기 위한 클로저 선언
    var pickedDate: ((_ date: Date) -> Void)?
    
    let timeTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "시간"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "ko")
        datePicker.minuteInterval = 1
        return datePicker
    }()
    
    let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar(frame: .zero)

        return navigationBar
    }()
    
    override func viewWillLayoutSubviews() {
        setupNavigaionBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupTimeTitleLabel()
        setupDatePicker()
    }
    
    private func setupTimeTitleLabel() {
        let guide = self.view.safeAreaLayoutGuide
        timeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(timeTitleLabel)
        NSLayoutConstraint.activate([
            timeTitleLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 80),
            timeTitleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
        ])
    }
    
    private func setupDatePicker() {
        let guide = self.view.safeAreaLayoutGuide
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.widthAnchor.constraint(equalToConstant: 193),
            datePicker.heightAnchor.constraint(equalToConstant: 50),
            datePicker.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            datePicker.centerYAnchor.constraint(equalTo: timeTitleLabel.centerYAnchor),
        ])
    }
    
    private func setupNavigaionBar() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: self.view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        let navigationItem = UINavigationItem(title: "알림 추가")
        let leftCancelButton: UIBarButtonItem = .init(title: "취소", style: .plain, target: self, action: #selector(dismissButtonTapped(_:)))
        let rightSaveButton: UIBarButtonItem = .init(title: "확인", style: .plain, target: self, action: #selector(saveButtonTapped(_:)))
        navigationItem.leftBarButtonItem = leftCancelButton
        navigationItem.rightBarButtonItem = rightSaveButton
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    @objc func saveButtonTapped(_ sender: UIBarButtonItem) {
        pickedDate?(datePicker.date)
        print("saveButtonTapped")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissButtonTapped(_ sender: UIBarButtonItem) {
        print("dismissButtonTapped")
        self.dismiss(animated: true, completion: nil)
    }
    
}
