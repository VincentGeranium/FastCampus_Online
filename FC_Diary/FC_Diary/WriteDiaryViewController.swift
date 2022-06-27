//
//  WriteDiaryViewController.swift
//  FC_Diary
//
//  Created by Morgan Kang on 2022/01/12.
//

import UIKit

enum DiaryEditorMode {
    case new
    // edit는 연관값으로 IndexPath와 Diary 객체를 전달 받을 수 있도록 한다.
    case edit(Diary)
}

protocol WriteDiaryViewDelegate: AnyObject {
    func didSelectRegister(diary: Diary)
    
}

class WriteDiaryViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.text = "제목"
        return label
    }()
    
    var titleTextField: UITextField = {
        var textField: UITextField = UITextField()
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor.placeholderText.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5.0
        return textField
    }()
    
    let contentsLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.text = "내용"
        return label
    }()
    
    var contentTextView: ContentsTextView = ContentsTextView()
    
    let dateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.text = "날짜"
        return label
    }()
    
    var dateTextField: UITextField = {
        var textField: UITextField = UITextField()
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor.placeholderText.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5.0
        return textField
    }()
    
    private var registerButton: UIBarButtonItem?
    private let datePicker: UIDatePicker = UIDatePicker()
    weak var delegate: WriteDiaryViewDelegate?
    
    // DiaryEditorMode를 저장하는 프로퍼티
    var diaryEditorMode: DiaryEditorMode = .new
    
    // date picker에서 선택된 date를 저장하는 프로퍼티
    private var diaryDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        self.title = "일기 작성."
        
        self.setupTitleLabel()
        self.setupTitleTextField()
        self.setupContentsLabel()
        self.setupContentsTextView()
        self.setupDateLabel()
        self.setupDateTextField()
        self.configureRegisterBarButtonItem()
        self.configureContentTextView()
        self.configureDatePicker()
        self.configureInputField()
//        self.configureEditMode()
        
        // 등록버튼의 비활성화.
            // 처음에는 어떤 내용도 들어있지 않을테니 등록버튼의 default 값을 비활성화로 만든다.
        self.registerButton?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureEditMode()

        print("WriteDiaryViewController")
    }
    
    private func configureEditMode() {
        // diaryEditorMode가 .edit이라면 연관값으로 전달받은 diary 객체를 view에 초기화
        switch self.diaryEditorMode {
        case let .edit(diary):
            self.titleTextField.text = diary.title
            self.contentTextView.text = diary.contents
            self.dateTextField.text = self.dateToString(date: diary.date)
            self.diaryDate = diary.date
            self.registerButton?.title = "수정"
        case .new:
            self.titleTextField.text = nil
            self.contentTextView.text = nil
            self.dateTextField.text = nil
            self.diaryDate = nil
            self.registerButton?.isEnabled = false
            
        default:
            break
        }
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
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
        ])
    }
    
    private func setupTitleTextField() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(titleTextField)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12),
            titleTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            titleTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
        ])
    }
    
    private func setupContentsLabel() {
        contentsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(contentsLabel)
        
        NSLayoutConstraint.activate([
            contentsLabel.topAnchor.constraint(equalTo: self.titleTextField.bottomAnchor, constant: 24),
            contentsLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            contentsLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
        ])
    }
    
    private func setupContentsTextView(){
        
//        contentTextView = .init()
        
//        guard let contentTextView = contentTextView else { return }
        
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(contentTextView)
        
        NSLayoutConstraint.activate([
            contentTextView.topAnchor.constraint(equalTo: self.contentsLabel.bottomAnchor, constant: 24),
            contentTextView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            contentTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            contentTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    open func configureContentTextView() {
//        guard let contentTextView = contentTextView else {
//            return
//        }
        
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        
        contentTextView.layer.borderColor = borderColor.cgColor
        contentTextView.layer.borderWidth = 0.5
        contentTextView.layer.cornerRadius = 5.0
    }
    
    private func setupDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(dateLabel)
        
//        guard let contentTextView = contentTextView else {
//            return
//        }
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 24),
            dateLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            dateLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
        ])
    }
    
    private func setupDateTextField() {
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(dateTextField)
        
        NSLayoutConstraint.activate([
            dateTextField.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 12),
            dateTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            dateTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24)
        ])
    }
    
    private func configureRegisterBarButtonItem() {
        registerButton = .init(title: "등록", style: .plain, target: self, action: #selector(didTapRegisterButton(_:)))
        
        self.navigationItem.rightBarButtonItem = registerButton
    }
    
    @objc private func didTapRegisterButton(_ sender: UIBarButtonItem) {
        // 수정(등록 버튼이 수정버튼으로 바뀌었을 때) 버튼을 누르면 포스트 메서드를 호출
        
        // 등록 버튼이 눌렸을 때 Diary 객체를 생성하고 delegate의 didSelectRegister 메소드를 호출.
        // 메소드 파라미터에 생성된 Diary 객체를 전달.
        guard let title = self.titleTextField.text else { return }
        print("🤔\(title)")
        guard let contents = self.contentTextView.text else { return }
        print("🤔\(contents)")
        guard let date = self.diaryDate else { return }
        print("🤔\(date)")
        switch self.diaryEditorMode {
        case .new:
            // 일기를 등록하는 행위를 해야한다.
            let diary = Diary(
                // 일기를 생성시 각 일기마다 고유한 uuid 값이 생성이 된다.
                uuidString: UUID().uuidString,
                title: title,
                contents: contents,
                date: date,
                isBookMark: false
            )
            self.delegate?.didSelectRegister(diary: diary)
        case let .edit(diary):
            // 일기를 수정해야 하는 행위를 해야한다.
            // case 문 안에 notificationCenter의 post 메서드를 이용해서 수정된 다이어리 객체를 전달.
            // 수정 버튼을 눌렀을 때 노티피케이션 센터가 ediDiary라는 노티피케이션 키를 옵져빙하는 곳에 수정된 diary 객체를 전달하게 된다.
            let diary = Diary(
                // Diary 에 저장되어 있는 uuid값이 전달
                uuidString: diary.uuidString,
                title: title,
                contents: contents,
                date: date,
                isBookMark: diary.isBookMark
            )
            NotificationCenter.default.post(
                name: NSNotification.Name("editDiary"),
                object: diary,
                userInfo: nil
            )
        }
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureDatePicker() {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        // datePicker의 value가 바뀔 때 마다 datePicker의 datePickerValueDidChanger(_:)가 호출된다.
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        self.datePicker.locale = Locale(identifier: "ko_KR")
        // textField를 선택했을 때 키보드가 아닌 datePicker가 나타나게 된다.
        self.dateTextField.inputView = self.datePicker
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formmater.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.dateTextField.text = formmater.string(from: datePicker.date)
        
        // ‼️ 문제점 : dateTextField는 text를 키보드로 입력받는 형태가 아니여서(.wheels) datePicker로 날자를 변경해도 dateTextFieldDidChange 메소드가 호출되지 않는다.
        // ✌️ 해결책 : datePicker의 날짜가 변경 될 때마다 .editingChanged 액션을 발생시켜 dateTextFieldDidChange 메서드가 호출되게 구현 -> 즉, self.dateTextField.addTarget 메소드가 동작하지 않는것을 sendActions 메소드를 이용하여 해결.
        // 📌 이렇게 구현하면 날짜가 변경될 때마다 .editingChanged 액션을 발생시켜 dateTextFieldDidChange 메소드가 호출되게 된더.
        self.dateTextField.sendActions(for: .editingChanged)
    }
    
    // 유저가 화면을 터치했을 때 호출되는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 키보드나 데이트 피커가 내려가게 만드는 코드
        self.view.endEditing(true)
    }
    
    private func configureInputField() {
        self.contentTextView.delegate = self
        
        // 제목 텍스트 필드의 텍스트가 입력될 때마다 titleTextFieldDidChange 메서드가 호출
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        
        // 날자 텍스트 필드의 날자가 변경될 때마다 dateTextFieldDidChange 메서드가 호출
        self.dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func titleTextFieldDidChange(_ textField: UITextField) {
        self.validateInputField()
    }
    
    @objc private func dateTextFieldDidChange(_ textField: UITextField) {
        self.validateInputField()
    }
    
    // 등록 버튼의 활성화를 판단하기 위한 메서드.
    private func validateInputField() {
//        guard let contentTextView = contentTextView else {
//            return
//        }
        
        // 모든 textField와 textView가 비어있지 않을 경우 등록 버튼이 활성화 되게 코드 작성.
        self.registerButton?.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !contentTextView.text.isEmpty
    }
}

extension WriteDiaryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
    }
}
