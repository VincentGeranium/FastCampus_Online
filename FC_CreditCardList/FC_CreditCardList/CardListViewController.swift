//
//  CardListViewController.swift
//  FC_CreditCardList
//
//  Created by Morgan Kang on 2022/02/07.
//

import UIKit
import Kingfisher
import FirebaseDatabase
import FirebaseFirestore
import FirebaseFirestoreSwift

class CardListViewController: UITableViewController {
    // Firebase realtime database 를 가져올 수 있는 reference
    var ref: DatabaseReference?
    
    // db 선언
//    let db = Firestore.firestore()
    
    let cardDetailVC = CardDetailViewController()
    
    // 전달 받은 가공된 형태의 데이터 지정
    var creditCardList: [CreditCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "카드 혜택 추천"
        
        // UITableView cell register
        self.tableView.register(CardListCell.self, forCellReuseIdentifier: CardListCell.reuseIdentifier)
        
        // 실시간 데이터 베이스 읽기
        // 아래와 같이 코드 작성시 Firebase가 나의 database를 잡아내고 앞으로 realtime database에서 만들어낸 데이터 흐름들을 주고 받게 될 것이다.
        ref = Database.database().reference()
        
        guard let ref = ref else { return }
        
        ref.observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: [String: Any]] else { return }

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
                let cardList = Array(cardData.values)
                self.creditCardList = cardList.sorted(by: { left, right in
                    left.rank < right.rank
                })


                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            } catch let error {
                debugPrint("Error JSON Parsing : \(error.localizedDescription)")
            }
        }
        
        // Firestore 읽기
            // realtime db읽기에서 observe를 사용했던것 처럼 firestore에서는 addSnapshotListener를 사용한다
//        db.collection("creditCardList").addSnapshotListener { snapshot, error in
            // db내부의 문서에 접근하여 읽기.
//            guard let documents = snapshot?.documents else {
//                print("Error Firestore fetching document \(String(describing: error))")
//                return
//            }
            
            // 값이 있다면 creditCard 객체 리스트로 가져오기 위한 작업
                // c.f _ compactMap을 쓴 이유는 nil 값을 배열에 넣지 않기 위해서이다
                    // 배열인 creditCardList에는 순수한 CreditCardList 타입의 리스트들만 들어가게 만들 의도이기 때문이다. -> 즉, 옵셔널 처리를 해준것.
//            self.creditCardList = documents.compactMap({ doc -> CreditCard? in
                // JSONParsing이 throw이기 때문에 do-try-chatch
//                do {
//                    // JSONParsing
//                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
//                    let creditCard = try JSONDecoder().decode(CreditCard.self, from: jsonData)
//                    return creditCard
//                } catch let error {
//                    print("JSON Parsing error \(error)")
//                    return nil
//                }
//            }).sorted(by: { left, right in
//                left.rank < right.rank
//            })
            
            // tableview reload data
                // 가져온 배열을 tableview에 뿌려주기 위함.
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
    }
    
    // 단일 섹션의 테이블 뷰를 만들 것이므로 카드 배열의 인덱스 수가 곧 row의 수가 될 것이다.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }
    
    // 커스텀 셀과 그 전달될 셀을 지정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardListCell.reuseIdentifier, for: indexPath) as? CardListCell else { return UITableViewCell() }
        
        cell.cardListStackView.cardNameLabelStackView.rankAndPromotionStackView.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.cardListStackView.cardNameLabelStackView.rankAndPromotionStackView.promotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.cardListStackView.cardNameLabelStackView.cardNameLabel.text = "\(creditCardList[indexPath.row].name)"

        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        cell.cardListStackView.cardImageView.kf.setImage(with: imageURL, placeholder: nil, options: nil, completionHandler: nil)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cardDetailVC.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.navigationController?.pushViewController(cardDetailVC, animated: true)
        
        // 실시간 데이터 베이스 쓰기
        // Option 1
        let cardID = creditCardList[indexPath.row].id
        // reference에 child 추가
            // 카드 선택시 realtime database에 각 선택된 Item에 isSelected라는 child가 생성되고 그 값으로 true값이 설정된다.
        ref?.child("Item\(cardID)/isSelected").setValue(true)
        
        // Option2
//        let cardID = creditCardList[indexPath.row].id
        // child 중 'id'가 key인 것을 검색하여 FIRDatabaseQuery타입으로 리턴해준다
            // .queryEqual(toValue: cardID)을 사용하여 cardID의 값과 "id"의 키 값이 같다면 "id"키가 가진 value를 FIRDatabaseQuery instance 타입으로 리턴해준다.
                // 그렇게 해서 observe를 통해 데이터를 가져오면 된다.
//        ref?.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value, with: { [weak self] snapshot in
//
//            guard let self = self else { return }
//            guard let value = snapshot.value as? [String: [String: Any]] else { return }
//            guard let key = value.keys.first else { return }
//
//            self.ref?.child("\(key)/isSelected").setValue(true)
//        })
        
        // Firestore 쓰기
            // cell을 선택했을 때 isSelected가 true 값을 가지도록 만든다.
        
        // Firestore 또한 경로를 알고 있을 때 쓰기와 모를 때 쓰기 방법이 다르다.
        
        // Option1 -> 경로를 알고 있는 경우.
//        let cardID = creditCardList[indexPath.row].id
        // isSelected라는 키, 값은 true인 데이터를 이 경로에 써준다.
//        db.collection("creditCardList").document("card\(cardID)").updateData(["isSelected": true])
        
        // Option2 -> 경로를 모를 때.
//        let cardID = creditCardList[indexPath.row].id
//        db.collection("creditCardList").whereField("id", isEqualTo: cardID).getDocuments { snapshot, error in
//            // 배열로 전달된 문서의 첫 번째를 추출
//            guard let document = snapshot?.documents.first else {
//                print("ERROR Firestore fetching documents")
//                return
//            }
//            // 값이 있다면 document의 reference에 updateData를 해라.
//            document.reference.updateData(["isSelected": true])
//        }
    }
    
    //tabelView의 edit을 허용/불가를 결정하는 메서드
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // editStyle을 결정하는 메서드
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // editingStyle이 delete일 경우에 어떤 액션을 취할 것인지 아래의 코드에 구현.
            
            // 실시간 데이터 베이스 삭제
            // Option1 -> 경로를 알 때(특정 path를 알 때)
            let cardID = creditCardList[indexPath.row].id
            ref?.child("Item\(cardID)").removeValue()
            
            // Option2 -> 경로를 모를 때(특정 path를 모를 때)
//            let cardID = creditCardList[indexPath.row].id
//            ref?.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value, with: { [weak self] snapshot in
//
//                guard let self = self else { return }
//                guard let value = snapshot.value as? [String: [String: Any]] else { return }
//                guard let key = value.keys.first else { return }
//
//                self.ref?.child(key).removeValue()
//            })
            
            // Firestore 삭제
            // Option1 -> 경로를 알 때
//            let cardID = creditCardList[indexPath.row].id
//            db.collection("creditCardList").document("card\(cardID)").delete()
            
            // Option2 -> 경로를 모를 때
//            let cardID = creditCardList[indexPath.row].id
//            db.collection("creditCardList").whereField("id", isEqualTo: cardID).getDocuments { snapshot, error in
//                
//                guard let document = snapshot?.documents.first else {
//                    print("ERROR \(String(describing: error?.localizedDescription))")
//                    return
//                }
//                
//                // document의 reference(경로)로가서 삭제.
//                document.reference.delete()
//            }
        }
    }
}
