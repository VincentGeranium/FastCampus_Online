//
//  NoticeViewController.swift
//  FC_Notice
//
//  Created by Morgan Kang on 2022/02/11.
//

import UIKit

class NoticeViewController: UIViewController {
    // 각 label의 text는 원격구성을 통해 받아온 정보로 부터 표시 할 것임.
    // 원격구성을 NoticeViewController가 아닌 ViewController에서 받아올 것 이다.
    // 그 이유는 이 NoticeViewController를 표시할 지 안할 지도 원격구성을 통해 제어해야 하기 때문.
    // 따라서 아래의 튜플을 추가한다.
        // ViewController에서 받아온다고 가정하고.
        // 해당 값은 못 받을 수도 있기 때문에 optional
    var noticeContents: (title: String, detail: String, date: String)?
    
    let noticeView: NoticeView = {
        let view: NoticeView = NoticeView(frame: .zero)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .white
        setupNoticeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // pop-up 처럼 보이기 위해 noticeView가 가지는 기본 뷰의 backgroundColor을 설정
            // 즉 noticeView를 제외한 view를 알파값을 가진 black 컬러로 설정
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        configureNoticeView()
        configureDoneButton()
        
        guard let noticeContents = noticeContents else { return }
        // 값이 있다면
        noticeView.mainStackView.titleLabel.text = noticeContents.title
        noticeView.mainStackView.detailLabel.text = noticeContents.detail
        noticeView.mainStackView.dateLabel.text = noticeContents.date

    }
    
    private func setupNoticeView() {
        let guide = self.view.safeAreaLayoutGuide
        
        noticeView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(noticeView)
        
        NSLayoutConstraint.activate([
            noticeView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            noticeView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            noticeView.widthAnchor.constraint(equalToConstant: 300),
            noticeView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
    
    private func configureNoticeView() {
        self.noticeView.layer.cornerRadius = 6
    }
    
    private func configureDoneButton() {
        noticeView.mainStackView.doneButton.addTarget(self, action: #selector(doneButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func doneButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        debugPrint("done button tapped")
    }
}
