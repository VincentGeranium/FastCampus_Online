//
//  BookMarkViewController.swift
//  FC_Diary
//
//  Created by Morgan Kang on 2022/01/10.
//

import UIKit

class BookMarkViewController: UIViewController {
    let diaryDetailViewController = DiaryDetailViewController()
    
    let bookMarkCollectionView: BookMarkCollectionView = {
        let layout: BookMarkCollectionViewFlowLayout = BookMarkCollectionViewFlowLayout()
        let collectionView: BookMarkCollectionView = BookMarkCollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private var diaryList: [Diary] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        setupBookMarkCollectionView()
        
        self.bookMarkCollectionView.delegate = self
        self.bookMarkCollectionView.dataSource = self
        
        self.loadBookMarkDiaryList()
        
        // 수정이 일어났을 때 관찰하는 옵져버 ("editDiary"라는 이름의 Notification을 관찰)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_:)),
            name: NSNotification.Name("editDiary"),
            object: nil
        )
        
        // 즐겨찾기가 일어났을 때 관찰하는 옵져버 ("bookMarkDiary"라는 이름의 Notification을 관찰)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(bookMarkDiaryNotification(_:)),
            name: NSNotification.Name("bookMarkDiary"),
            object: nil
        )
        
        // 삭제이 일어났을 때 관찰하는 옵져버 ("deleteDiary"라는 이름의 Notification을 관찰)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(deleteDiaryNotification(_:)),
            name: NSNotification.Name("deleteDiary"),
            object: nil
        )
    }
    
    private func setupBookMarkCollectionView() {
        bookMarkCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(bookMarkCollectionView)
        
        NSLayoutConstraint.activate([
            bookMarkCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            bookMarkCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            bookMarkCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            bookMarkCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // userDefault에 저장된 diaryList 데이터를 가져오기 -> 즐겨찾기된 일기만 가져오기.
    private func loadBookMarkDiaryList() {
        // userDefaults에 접근
        let userDefaults = UserDefaults.standard
        //object 메서드 forKey parameter 값으로 "diaryList" 키 값을 넘겨줘서 diaryList 데이터를 가져온다.
            // objcet 메서드는 Any 타입으로 리턴되기 때문에 딕셔너리 배열로 타입 캐스팅해준다.
                // typecasting 에 실패하면 nil이 될 수 있으므로 옵셔널 바인딩 해준다.
        guard let data = userDefaults.object(forKey: "diaryList") as? [[String: Any]] else { return }
        
        // 불러온 데이터를 diaryList에 넣어준다.
            // compactMap을 이용하여 diar 타입 배열이 되도록 매핑한다.
        self.diaryList = data.compactMap({ data in
            guard let uuidString = data["uuidString"] as? String else { return nil }
            // title key값으로 title value 값을 가져오는데 any type이므로 string type으로 typecasting.
            guard let title = data["title"] as? String else { return nil }
            guard let contents = data["contents"] as? String else { return nil }
            guard let date = data["date"] as? Date else { return nil }
            guard let isBookMark = data["isBookMark"] as? Bool else { return nil }
            
            return Diary(
                uuidString: uuidString,
                title: title,
                contents: contents,
                date: date,
                isBookMark: isBookMark
            )
        }).filter({
            // 불러온 diaryList를 filter 고차함수를 이용하여 즐겨찾기 된 일기면 가져오게 만든다.
            $0.isBookMark == true
        }).sorted(by: {
            // sorted 함수를 이용하여 날짜가 최신순으로 정렬되도록 구현.
            $0.date.compare($1.date) == .orderedDescending
        })
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        // 전부 notificaiton을 통해 전달한 데이터들
        guard let diary = notification.object as? Diary else { return }
        // 배열의 요소에 전달받은 uuid 값이 있는지 확인 후 있다면 그 해당하는 index로 배열에 수정된 일기의 내용이 업데이트되게 한다.
            // firstIndex 고차함수를 이용해서 배열을 iteration(반복)해서 notification에서 전달 받은 uuid와 같은 값이 배열의 요소에 있는지 확인후 있다면 해당 요소의 index를 리턴 받을 수 있게한다.
                // c.f _ 만약 없다면 nil을 반환하므로 옵셔널 바인딩을 해야한다.
        guard let index = self.diaryList.firstIndex(where: { diaryList in
            diaryList.uuidString == diary.uuidString
        }) else { return }
        
        // 수정된 내용을 대입
        self.diaryList[index] = diary
        // sorted 고차함수로 일기가 최신순으로 정렬되게 만든다.
        self.diaryList = self.diaryList.sorted(by: { left, right in
            left.date.compare(right.date) == .orderedDescending
        })
        self.bookMarkCollectionView.reloadData()
    }
    
    @objc func bookMarkDiaryNotification(_ notification: Notification) {
        guard let bookMarkDiary = notification.object as? [String: Any] else { return }
        guard let isBookMark = bookMarkDiary["isBookMark"] as? Bool else { return }
        guard let uuidString = bookMarkDiary["uuidString"] as? String else { return }
        guard let diary = bookMarkDiary["diary"] as? Diary else { return }
        

        
        
        if isBookMark {
            self.diaryList.append(diary)
            // sorted 고차함수로 일기가 최신순으로 정렬되게 만든다.
            self.diaryList = self.diaryList.sorted(by: { left, right in
                left.date.compare(right.date) == .orderedDescending
            })
            self.bookMarkCollectionView.reloadData()
        } else {
            // 배열의 요소에 전달받은 uuid 값이 있는지 확인 후 있다면 그 해당하는 index로 배열에 수정된 일기의 내용이 업데이트되게 한다.
                // firstIndex 고차함수를 이용해서 배열을 iteration(반복)해서 notification에서 전달 받은 uuid와 같은 값이 배열의 요소에 있는지 확인후 있다면 해당 요소의 index를 리턴 받을 수 있게한다.
                    // c.f _ 만약 없다면 nil을 반환하므로 옵셔널 바인딩을 해야한다.
            guard let index = self.diaryList.firstIndex(where: { diaryList in
                diaryList.uuidString == uuidString }) else { return }
            
            self.diaryList.remove(at: index)
            self.bookMarkCollectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
        }
    }
    
    @objc func deleteDiaryNotification(_ notification: Notification) {
        guard let uuidString = notification.object as? String else { return }
        // 배열의 요소에 전달받은 uuid 값이 있는지 확인 후 있다면 그 해당하는 index로 배열에 수정된 일기의 내용이 업데이트되게 한다.
            // firstIndex 고차함수를 이용해서 배열을 iteration(반복)해서 notification에서 전달 받은 uuid와 같은 값이 배열의 요소에 있는지 확인후 있다면 해당 요소의 index를 리턴 받을 수 있게한다.
                // c.f _ 만약 없다면 nil을 반환하므로 옵셔널 바인딩을 해야한다.
        guard let index = self.diaryList.firstIndex(where: { diaryList in
            diaryList.uuidString == uuidString
        }) else { return }
        
        self.diaryList.remove(at: index)
        self.bookMarkCollectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
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

extension BookMarkViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 즐겨찾기된 diaryList의 요소(일기) 갯수 만큼 cell이 표시되어야 한다.
        return self.diaryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // BookMarkCollectionViewCell로 다운캐스팅
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookMarkCollectionViewCell.cellIdentifier, for: indexPath) as? BookMarkCollectionViewCell else { return UICollectionViewCell() }
        
        let diary = self.diaryList[indexPath.row]
        cell.bookMarkLabelStackView.titleLabel.text = diary.title
        cell.bookMarkLabelStackView.dateLabel.text = self.dateToString(date: diary.date)
        return cell
    }
    
    
}

extension BookMarkViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 즐겨찾기한 일기는 리스트 형식으로 보여줄 것이므로 cell의 width값을 UIScreen.main.bound.width 값으로 준다.
            // 아이폰 화면의 너비값이 셀의 너비 값이 되게 해주는 것.
                // 여기서 BookMarkCollectionView의 contentInset에 설정한 left, right 값 만큼 빼준다.
        return CGSize(width: UIScreen.main.bounds.width - 20, height: 80)
    }
}

extension BookMarkViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // indexPath.row를 이용하여 diaryList의 요소 가져오기
        let diary = self.diaryList[indexPath.row]
        
        // DiaryDetailViewController에 선언된 diary property에 diary를 넘겨준다
        self.diaryDetailViewController.diary = diary
        
        // DiaryDetailViewController에 선언된 indexPath property에 indexPath를 넘겨준다.
        self.diaryDetailViewController.indexPath = indexPath
        
        self.navigationController?.pushViewController(self.diaryDetailViewController, animated: true)
    }
    
}
