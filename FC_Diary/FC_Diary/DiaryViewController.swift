//
//  ViewController.swift
//  FC_Diary
//
//  Created by Morgan Kang on 2022/01/10.
//

import UIKit

class DiaryViewController: UIViewController {
    let writeDiaryVC = WriteDiaryViewController()
    let diaryDetailVC = DiaryDetailViewController()
    
    let diaryCollectionView: DiaryCollectionView = {
        let layout = DiaryCollectionViewFlowLayout()
        let collectionView: DiaryCollectionView = DiaryCollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    // property observer로 만든다.
    var diaryList = [Diary]() {
        didSet {
            // 다이어리 리스트에 일기가 추가되거나 변경이 일어날 때마다 userDefaults에 저장되게 된다.
            self.saveDiaryList()
        }
    }
    
    var addButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        writeDiaryVC.delegate = self
        
        print(diaryList.count)
        
        self.configureCollectionView()
        self.setupDiaryCollectionView()
//        self.setupAddBarButtonItem()
        self.loadDiaryList()
        
        // editDiary 키 값을 가진 NotificationCenter post를 관찰하는 observer
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotificaion(_:)),
            name: NSNotification.Name("editDiary"),
            object: nil
        )
        
        // bookMarkDiary 키 값을 가진 NotificationCenter post를 관찰하는 observer
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(bookMarkDiaryNotification(_:)),
            name: NSNotification.Name("bookMarkDiary"),
            object: nil
        )
        
        // deleteDiary 키 값을 가진 NotificationCenter post를 관찰하는 observer
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(deleteDiaryNotification(_:)),
            name: NSNotification.Name("deleteDiary"),
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupAddBarButtonItem()
        print("DiaryViewController")
    }
    
    @objc func editDiaryNotificaion(_ notification: Notification) {
        // 전달 받은 diary 객체 가져오기
        guard let diary = notification.object as? Diary else { return }
        
        // 배열의 요소에 전달받은 uuid 값이 있는지 확인 후 있다면 그 해당하는 index로 배열에 수정된 일기의 내용이 업데이트되게 한다.
            // firstIndex 고차함수를 이용해서 배열을 iteration(반복)해서 notification에서 전달 받은 uuid와 같은 값이 배열의 요소에 있는지 확인후 있다면 해당 요소의 index를 리턴 받을 수 있게한다.
                // c.f _ 만약 없다면 nil을 반환하므로 옵셔널 바인딩을 해야한다.
        
        guard let index = self.diaryList.firstIndex(where: { diaryList in
            diaryList.uuidString == diary.uuidString
        }) else { return }
        

        self.diaryList[index] = diary
        
        // sort 고차함수로 날짜를 최신순으로 정렬
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        
        // collectionView의 reloadData를 이용해 collectionView에 수정된 내용을 적용.
        self.diaryCollectionView.reloadData()
    }
    
    @objc func bookMarkDiaryNotification(_ notification: Notification) {
        // NotificationCenter의 post를 이용해 objcet에 전달하려하는 데이터를 전달했다.
        
        // 딕셔너리 형태로 데이터를 전달하기 때문에 as? [String: Any]로 타입캐스팅 해준다.
        guard let bookMarkDiary = notification.object as? [String: Any] else { return }
        // isBookMark라는 키로 value를 가져온다, value 값이 any type이므로 bool type으로 타입캐스팅 해준다.
        guard let isBookMark = bookMarkDiary["isBookMark"] as? Bool else { return }
        guard let uuidString = bookMarkDiary["uuidString"] as? String else { return }
        
        // 배열의 요소에 전달받은 uuid 값이 있는지 확인 후 있다면 그 해당하는 index로 배열에 수정된 일기의 내용이 업데이트되게 한다.
            // firstIndex 고차함수를 이용해서 배열을 iteration(반복)해서 notification에서 전달 받은 uuid와 같은 값이 배열의 요소에 있는지 확인후 있다면 해당 요소의 index를 리턴 받을 수 있게한다.
                // c.f _ 만약 없다면 nil을 반환하므로 옵셔널 바인딩을 해야한다.
        
        guard let index = self.diaryList.firstIndex(where: { diaryList in
            diaryList.uuidString == uuidString
        }) else { return }
        
        // "bookMarkDiary" 키를 가진 노티피케이션이 호출되면 즉, 일기장 화면에서 즐겨찾기 토글이 일어나면
        // 전달 받은 즐겨찾기 여부를 diaryList 배열에 업데이트한다.
        // 전달 받은 isBookMark 데이터를 대입하여 즐겨찾기 정보를 업데이트 해준다.
        self.diaryList[index].isBookMark = isBookMark
    }
    
    @objc func deleteDiaryNotification(_ notification: Notification) {
        // post로 전달한 indexPath를 가져온다.
        guard let uuidString = notification.object as? String else { return }
        
        // 배열의 요소에 전달받은 uuid 값이 있는지 확인 후 있다면 그 해당하는 index로 배열에 수정된 일기의 내용이 업데이트되게 한다.
            // firstIndex 고차함수를 이용해서 배열을 iteration(반복)해서 notification에서 전달 받은 uuid와 같은 값이 배열의 요소에 있는지 확인후 있다면 해당 요소의 index를 리턴 받을 수 있게한다.
                // c.f _ 만약 없다면 nil을 반환하므로 옵셔널 바인딩을 해야한다.
        guard let index = self.diaryList.firstIndex(where: { diaryList in
            diaryList.uuidString == uuidString
        }) else { return }
        
        // 전달받은 index값의 배열 요소 값을 삭제
        self.diaryList.remove(at: index)
        // 전달받은 index를 row에 넘겨줘서 컬렉션 뷰의 일기를 삭제, 단일 섹션이므로 section에는 0을 넘겨줌.
        self.diaryCollectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
    }
    
    private func configureCollectionView() {
        self.diaryCollectionView.delegate = self
        self.diaryCollectionView.dataSource = self
    }
        
    private func setupDiaryCollectionView() {
        diaryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(diaryCollectionView)
        
        NSLayoutConstraint.activate([
            diaryCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            diaryCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            diaryCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            diaryCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupAddBarButtonItem() {
        self.addButton = .init(barButtonSystemItem: .add, target: self, action: #selector(didTapAddBarButtonItem(_:)))
        self.navigationItem.rightBarButtonItem = self.addButton
    }
    
    @objc private func didTapAddBarButtonItem(_ sender: UIBarButtonItem) {
//        writeDiaryVC.titleTextField.text = nil
//        writeDiaryVC.contentTextView.text = nil
//        writeDiaryVC.dateTextField.text = nil
        
        self.navigationController?.pushViewController(writeDiaryVC, animated: true)
    }
    
    // userDefaults에 일기를 저장하는 메서드.
    private func saveDiaryList() {
        // userDefault에 dictionary array 형태로 일기를 저장.
            // map으로 diaryList 배열에 있는 요소들을 Dictionary 형태로 mapping.
                // "title" 키에는 diaryList의 title이 저장되게 만든다.
                // "contents" 키에는 diaryList의 contents가 저장되게 등,, 각 키에 맞는 value를 저장되게 만든다.
        let data = diaryList.map { diary in
            [   "uuidString": diary.uuidString,
                "title": diary.title,
                "contents": diary.contents,
                "date": diary.date,
                "isBookMark": diary.isBookMark
            ]
        }
        // userDefaults.standard로 userDefaults에 접근할 수 있도록 정의.
        let userDefaults = UserDefaults.standard
        // set 메서드를 호출해서 첫 번째 파라미터에는 일기가 저장되어 있는 data를 넘겨주고 forKey 파라미터에는 그에 맞는 키 값을 넣어준다.
        userDefaults.set(data, forKey: "diaryList")
    }
    
    // userDefaaults에 저장되어 있는 데이터를 불러오는 메서드.
    private func loadDiaryList() {
        // userDefaults 상수 선언.
            // userDefaults.standard로 userDefaults에 접근하도록 만들기.
        let userDefaults = UserDefaults.standard
        
        // object의 파라미터에 data의 키 값인 "diaryList"를 넘겨줘 diaryList를 가져온다.
            // objcet 메서드는 Any type로 return 되기 때문에 Dictionary Array 형태로 typecasting 해줘야한다.
                // typecasting에 실패시 nil이 될 수 있으므로 guard 문으로 옵셔널 바인딩을 헤준다.
        guard let data = userDefaults.object(forKey: "diaryList") as? [[String: Any]] else { return }
        
        // 불러온 데이터를 diaryList에 넣어준다
            // compactMap 고차함수로 diaryList 형태로 맵핑이 되도록 만들어준다.
        self.diaryList = data.compactMap { dataDictionary in
            // 딕셔너리의 value가 Any 타입이므로 typecasting을 해주어야한다.
            guard let uuidString = dataDictionary["uuidString"] as? String else { return nil }
            guard let title = dataDictionary["title"] as? String else { return nil }
            guard let contents = dataDictionary["contents"] as? String else { return nil }
            guard let date = dataDictionary["date"] as? Date else { return nil }
            guard let isBookMark = dataDictionary["isBookMark"] as? Bool else { return nil }
            
            // Diary 타입이 되게 리턴해준다
            return Diary(uuidString: uuidString, title: title, contents: contents, date: date, isBookMark: isBookMark)
        }
        // sort 고차함수를 이용하여 배열을 날짜 순으로 정리하고 컬렉션 뷰에서 날짜 순으로 일기를 보여줄 수 있도록 한다.
            // 즉, 날짜가 최신순으로 정렬되게 로직을 짠다.
                // 배열을 왼쪽과 오른쪽을 이터레이션을 주어 비교하여 최신순으로 배열을 정렬
                    // compare 메서드를 통해 왼쪽의 값과 오른쪽의 값을 비교 -> 날짜가 내림차순으로 정렬되게 할 것임.
        self.diaryList = self.diaryList.sorted { leftValue, rightValue in
            leftValue.date.compare(rightValue.date) == .orderedDescending
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
}

extension DiaryViewController: UICollectionViewDataSource {
    // 지정된 섹션에 표시할 셀의 갯수를 뭍는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(diaryList.count)
        return self.diaryList.count
    }
    
    // collectionView에 지정된 위치에 표시할 셀을 요청하는 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiaryCollectionViewCell.cellIdentifier, for: indexPath) as? DiaryCollectionViewCell else {
            print("Cell casting error")
            return UICollectionViewCell() }
        
        let diary = self.diaryList[indexPath.row]
        
        cell.titleLabel.text = diary.title
        
        // diary 인스턴스의 date 프로퍼티는 Date 타입으로 되어 있으므로 dateFormatter를 이용하여 문자열로 만들어줘야 한다.
            // dateToString 메소드를 이용하여 date 타입으로 되어있는 것을 String 타입의 문자열로 만들어준다.
        cell.dateLabel.text = self.dateToString(date: diary.date)
        
        return cell
    }
}

extension DiaryViewController: UICollectionViewDelegate {
    // 특정 셀이 선택 되었음을 알리는 메서드.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //DiaryDetailViewController가 push 되도록 구현.
        
        // 선택한 셀이 뭔지 diary 상수에 대입
        let diary = self.diaryList[indexPath.row]
        print(self.diaryList[indexPath.row])
        
        diaryDetailVC.diary = diary
        diaryDetailVC.indexPath = indexPath
        
        self.navigationController?.pushViewController(diaryDetailVC, animated: true)
    }
}

extension DiaryViewController: UICollectionViewDelegateFlowLayout {
    // cell의 사이즈를 설정하는 역할을 하는 메서드.
        // 표시할 cell의 사이즈를 CGSize로 정의하고 리턴해주면 설정한 사이즈대로 cell이 표시된다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀이 행에 2개씩 표시되게 만들어 줄 것이므로 아이폰 스크린의 너비 값 / 2가 너비값이 되도록 할 것이다
            // 거기에 20을 빼는 이유는 left, right 에 contentInset 값을 10씩 주었으므로 -20을 해주는 것이다.
        // 높이는 200으로 주었으므로 contentInset의 top과 bottom값을 합친 값인 20까지 합하면 총 220이 보여지는 셀의 높이 값이 될 것이다.
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 200)
    }
    
}

extension DiaryViewController: WriteDiaryViewDelegate {
    
    func didSelectRegister(diary: Diary) {
        // 일기가 작성이 되면 didSelectRegister 메서드의 diary 파라미터를 통해 작성된 일기의 내용이 담겨져 있는 Diary 객체가 전달이 된다.
            // 이 Diary 객체를 diaryList에 추가.
                // 이렇게 되면 일기 작성화면에서 일기가 등록 될 때마다 다이어리 배열에 등록된 일기가 추가된다.
//        guard let diaryCollectionView = diaryCollectionView else { return }
        print(diaryList)
        
        self.diaryList.append(diary)
        
        // 처음 배열에 일기가 추가 된 후 배열의 일기를 날짜 내림차순으로 정렬하여 저장.
        self.diaryList = self.diaryList.sorted { leftValue, rightValue in
            leftValue.date.compare(rightValue.date) == .orderedDescending
        }
        
        self.diaryCollectionView.reloadData()
    }
}
