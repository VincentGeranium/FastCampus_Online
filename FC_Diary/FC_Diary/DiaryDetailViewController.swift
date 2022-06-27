//
//  DiaryDetailViewController.swift
//  FC_Diary
//
//  Created by Morgan Kang on 2022/01/12.
//

import UIKit

class DiaryDetailViewController: UIViewController {
    let writeDiaryVC = WriteDiaryViewController()
    
    let diaryDetailLabelStackView: DiaryDetailLabelStackView = {
        let stackView: DiaryDetailLabelStackView = DiaryDetailLabelStackView()
        
        [stackView.titleLabel,
         stackView.diaryTitleLabel].forEach { views in
            stackView.addArrangedSubview(views)
        }
        
        return stackView
    }()
    
    let contentsTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "내용"
        return label
    }()
    
    var contentsTextView: ContentsTextView?
    
    let diaryDateDetailLabelStackView: DiaryDetailLabelStackView = {
        let stackView: DiaryDetailLabelStackView = DiaryDetailLabelStackView()
        
        [stackView.titleLabel,
         stackView.diaryTitleLabel].forEach { views in
            stackView.addArrangedSubview(views)
        }
    
        return stackView
    }()
    
    let modifyAndDeleteButtonStackView: ModifyAndDeleteButtonStackView = {
        let stackView: ModifyAndDeleteButtonStackView = ModifyAndDeleteButtonStackView()
        
        [stackView.modifyButton,
         stackView.deleteButton].forEach { buttons in
            stackView.addArrangedSubview(buttons)
        }
        
        return stackView
    }()
    
    var diary: Diary?
    var indexPath: IndexPath?
    
    var bookMarkBarButton: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.setupDiaryDetailStackView()
        self.setupContentsTitleLabel()
        self.configureAndSetupContentsTextView()
        self.setupDiaryDateDetailLabelStackView()
        self.setupModifyAndDeleteButtonStackView()
        self.configureModifyAndDeleteButton()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(bookMarkDiaryNotification(_:)),
            name: NSNotification.Name("bookMarkDiary"),
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configureView()
        print("DiaryDetailViewController")
    }
    
    // Date 타입을 받아 String 타입으로 변환하여 반환해주는 함수 정의
    private func dateToString(date: Date) -> String {
        // DateFormatter를 사용하여 Date type을 String type으로 변환.
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        
        // dateFormat이 한국어로 표시되도록 identifier를 "ko_KR"로 넘겨준다.
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.string(from: date)
    }
    
    private func configureView() {
        guard let diary = self.diary else {
            return
        }
        
        self.diaryDetailLabelStackView.diaryTitleLabel.text = diary.title
        self.contentsTextView?.text = diary.contents
        self.diaryDateDetailLabelStackView.diaryTitleLabel.text = self.dateToString(date: diary.date)
        
        // bookMarkBarButton instance 생성
        self.bookMarkBarButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(didtapBookMarkButton(_:)))
        
        // bookMark, 즉 즐겨찾기가 되어 있는지 없는지에 따른 버튼의 이미지 처리 로직.
            // 즐겨찾기가 되어 있다면 'star.fill' 아니라면 'star'
        self.bookMarkBarButton?.image = diary.isBookMark ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        
        // tintColor을 orange로 설정하여 별이 orange 색상이 되도록 설정
        self.bookMarkBarButton?.tintColor = .orange
        self.navigationItem.rightBarButtonItem = self.bookMarkBarButton
        
    }
    
    private func setupDiaryDetailStackView() {
        diaryDetailLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        diaryDetailLabelStackView.titleLabel.text = "제목"
        
        self.view.addSubview(diaryDetailLabelStackView)
        
        NSLayoutConstraint.activate([
            diaryDetailLabelStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24),
            diaryDetailLabelStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            diaryDetailLabelStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24)
        ])
    }
    
    private func setupContentsTitleLabel() {
        contentsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(contentsTitleLabel)
        
        NSLayoutConstraint.activate([
            contentsTitleLabel.topAnchor.constraint(equalTo: self.diaryDetailLabelStackView.bottomAnchor, constant: 24),
            contentsTitleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            contentsTitleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
        ])
    }
    
    private func configureAndSetupContentsTextView() {
        contentsTextView = .init()
        
        if let contentsTextView = contentsTextView {
            contentsTextView.translatesAutoresizingMaskIntoConstraints = false
            
            contentsTextView.font = UIFont.systemFont(ofSize: 17)
            contentsTextView.isEditable = false
            
            self.view.addSubview(contentsTextView)
            
            NSLayoutConstraint.activate([
                contentsTextView.topAnchor.constraint(equalTo: self.contentsTitleLabel.bottomAnchor, constant: 12),
                contentsTextView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                contentsTextView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                contentsTextView.heightAnchor.constraint(equalToConstant: 150)
            ])
        }
    }
    
    private func setupDiaryDateDetailLabelStackView() {
        diaryDateDetailLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let contentsTextView = contentsTextView else {
            return
        }
        
        self.diaryDateDetailLabelStackView.titleLabel.text = "날짜"
//        self.diaryDateDetailLabelStackView.diaryTitleLabel.text = "label"

        self.view.addSubview(diaryDateDetailLabelStackView)
        
        NSLayoutConstraint.activate([
            diaryDateDetailLabelStackView.topAnchor.constraint(equalTo: contentsTextView.bottomAnchor, constant: 24),
            diaryDateDetailLabelStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            diaryDateDetailLabelStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
        ])
    }
    
    private func setupModifyAndDeleteButtonStackView() {
        modifyAndDeleteButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(modifyAndDeleteButtonStackView)
        
        NSLayoutConstraint.activate([
            modifyAndDeleteButtonStackView.topAnchor.constraint(equalTo: self.diaryDateDetailLabelStackView.bottomAnchor, constant: 24),
            modifyAndDeleteButtonStackView.centerXAnchor.constraint(equalTo: self.diaryDateDetailLabelStackView.centerXAnchor),
        ])
    }
    
    private func configureModifyAndDeleteButton() {
        modifyAndDeleteButtonStackView.modifyButton.addTarget(self, action: #selector(didTapModifyButton(_:)), for: .touchUpInside)
        modifyAndDeleteButtonStackView.deleteButton.addTarget(self, action: #selector(didTapDeleteButton(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapModifyButton(_ sender: UIButton) {
        // 수정 버튼을 누르면 WriteDiaryViewController에 선언된 diaryEditorMode 프로퍼티에 열거형값 .edit을 전달하게 된다.
            // 연관값으로 indePath와 diary 객체가 전달되게 된다.
        
        // diaryEditorMode 프로퍼티를 통해서 수정할 다이어리 객체를 전달.
//        guard let indexPath = indexPath else { return }
        guard let diary = diary else { return }
        
        self.writeDiaryVC.diaryEditorMode = .edit(diary)
        
        // 노티피케이션을 옵져빙 하는 코드
        // 수정 버튼을 눌렀을 때 editDiary 노티피케이션을 관찰하는 옵져버가 추가가 된다.
        // WriteDiaryViewController에서 수정된 diary 객체가 노티피케이션 센터를 통해서 포스트 될 때 editDiaryNotificaion(_:)메서드를 호출하게 된다.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_:)),
            name: NSNotification.Name("editDiary"),
            object: nil
        )
        
        self.navigationController?.pushViewController(writeDiaryVC, animated: true)
        print("did tap modify button")
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        // 수정된 diary 객체를 전달을 받아 view에 업데이트 되도록 코드 작성.
        
        // post에서 보낸 수정된 객체를 가저오는 코드 작성.
        guard let diary = notification.object as? Diary else { return }
        
        // 수정된 diary 객체를 대입.
        self.diary = diary
        
        // 수정된 일기 내용으로 view를 업데이트
        self.configureView()
    }
    
    @objc func bookMarkDiaryNotification(_ notification: Notification) {
        guard let bookMarkDiary = notification.object as? [String: Any] else { return }
        guard let isBookMark = bookMarkDiary["isBookMark"] as? Bool else { return }
        guard let uuidString = bookMarkDiary["uuidString"] as? String else { return }
        guard let diary = self.diary else { return }
        if diary.uuidString == uuidString {
            self.diary?.isBookMark = isBookMark
            self.configureView()
        }
    }
    
    @objc private func didTapDeleteButton(_ sender: UIButton) {
        guard let uuidString = self.diary?.uuidString else { return }
        
        // 삭제 기능 구현을 위한 NotificationCenter.post
        NotificationCenter.default.post(
            name: NSNotification.Name("deleteDiary"),
            object: uuidString,
            userInfo: nil
        )
        
        self.navigationController?.popViewController(animated: true)
        print("did tap delete button")
    }
    
    @objc func didtapBookMarkButton(_ sender: UIBarButtonItem) {
        // 즐겨찾기를 toggle하는 기능을 추가하는 코드.
        guard let isBookMark = self.diary?.isBookMark else { return }

        if isBookMark {
            // if isBookMark가 true일 경우
            self.bookMarkBarButton?.image = UIImage(systemName: "star")
        } else {
            // isBookMark가 false일 경우
            self.bookMarkBarButton?.image = UIImage(systemName: "star.fill")
        }
        // self.diary?.isBookMark에 true이면 false가 대입되게 false이면 true가 대입되도록 한다.
            // 이렇게 되면 즐겨찾기를 toggle 할 수 있게 된다.
        self.diary?.isBookMark = !isBookMark
        
        // NotificationCenter를 이용하여 데이터 전달.
        NotificationCenter.default.post(
            name: NSNotification.Name("bookMarkDiary"),
            object: [
                "diary": self.diary,
                "isBookMark": self.diary?.isBookMark ??  false,
                "uuidString": self.diary?.uuidString
            ],
            userInfo: nil
        )
    }
    
    deinit {
        // 인스턴스가 deinit 될 때 노티피케이션 removeObserver 메소드를 호출해서 해당 인스턴스 추가된 모두 제거되게 만들어 준다
            // 여기서는 self 즉, DiaryDetailViewController 인스턴스에 추가된 모든 노티피케이션 제거
        NotificationCenter.default.removeObserver(self)
    }

}
