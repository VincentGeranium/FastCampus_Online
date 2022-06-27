//
//  ViewController.swift
//  FC_ToDoList
//
//  Created by Morgan Kang on 2022/01/07.
//

import UIKit

class ViewController: UIViewController {
    
    let toDoListTableView: ToDoListTableView  = {
        let tableView: ToDoListTableView = ToDoListTableView()
        tableView.register(ToDoListTableViewCell.self, forCellReuseIdentifier: ToDoListTableViewCell.identifier)
        return tableView
    }()
    
    // 할 일들을 저장하는 배열
    var tasks = [Task]() {
        // 프로퍼티 옵저버
            // 이렇게 코드를 작성하면 tasks 배열에 할 일이 추가될 때마다 UserDefaults에 할 일이 저장된다
        didSet {
            self.saveTasks()
        }
    }
    
    var doneButton: UIBarButtonItem?
    var editButton: UIBarButtonItem?
    var addButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.toDoListTableView.dataSource = self
        self.toDoListTableView.delegate = self
        
        // viewDidLoad 시점에 loadTasks메소드를 호출해 UserDefaults에 저장된 할 일을 불러오게 구현.
        self.loadTasks()
        
        configureLeftBarButtonItem()
        configureRightBarButtonItem()
        configureDoneBarButtonItem()
        setupToDoListTableView()
    }
    
    private func setupToDoListTableView() {
        
        toDoListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(toDoListTableView)
        
        NSLayoutConstraint.activate([
            toDoListTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            toDoListTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            toDoListTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            toDoListTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureLeftBarButtonItem() {
        self.editButton = .init(barButtonSystemItem: .edit, target: self, action: #selector(didTapEditButton(_:)))
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = self.editButton
    }
    
    private func configureRightBarButtonItem() {
        self.addButton = .init(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton(_:)))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = self.addButton
    }
    
    private func configureDoneBarButtonItem() {
        self.doneButton = .init(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton(_:)))
    }
    
    @objc func didTapDoneButton(_ sender: UIBarButtonItem? = nil) {
        // navigationItem의 leftBarButtonItem이 다시 edit button이 되도록 만들기.
        self.navigationItem.leftBarButtonItem = self.editButton
        
        // tableView가 편집모드에서 빠져나오게 하는 코드.
        self.toDoListTableView.setEditing(false, animated: true)
    }
    
    @objc func didTapEditButton(_ sender: UIBarButtonItem) {
        // 테이블 뷰가 비어있을 경우 편집 모드로 들어갈 필요가 없으므로 tasks 배열이 비어있지 않을 때만 편집모드로 전환되게 guard code 작성.
        guard !self.tasks.isEmpty else { return }
        
        // leftBarButtonItem을 done 버튼으로 바뀌게 만들기.
        self.navigationItem.leftBarButtonItem = self.doneButton
        
        // setEditing 메서드에 true 파라미터를 전달하여 테이블 뷰를 편집모드로 전환되도록 만들기.
        self.toDoListTableView.setEditing(true, animated: true)
    }
    
    @objc func didTapAddButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "할 일 등록.", message: nil, preferredStyle: .alert)
        
        // 클로저 선언부에 캡쳐 목록을 정의함 -> [weak self]
            // 클로저 선언부에서 캡쳐 목록을 정의하는 이유는 클래스처럼 클로저는 참조타입이기 때문에 클로저의 본문에서 self로 클래스의 인스턴스를 캡쳐 할 때 강한 순환 참조가 발생할 수 있기 때문이다.
                // 두 개의 객체가 상호 참조하는 경우 강한 순환 참조가 만들어지는데 이렇게 될 경우 순환 참조와 연관된 객체들은 레퍼런스 카운트가 0에 도달하지 않게되고 결국 메모리 누수가 발생하게 된다.
                // 클로저와 클래스 인스턴스 사이에 강한 순환 참조를 해결하는 방법은 클로저의 선언부에서 캡쳐 목록을 정의하는 것으로 해결할 수 있다.
                    // [weak self] 이것이 캡쳐 목록을 정의한 것 이라고 생각하면 된다.
                // 클로저 선언부에 [weak self]나 unowend로 정의하지 않고 클로저 본문에서 self 키워드로 클래스의 인스턴스의 프로퍼티에 접근하게 될 경우 강한 순환 참조가 발생해 메모리 누수가 발생할 수 있다.
        let registerButton = UIAlertAction(title: "등록", style: .default) { [weak self] _ in
            // 등록 버튼을 눌렀을 때 textField의 값을 가져오게 하는 코드.
                // 텍스트필드 프로퍼티는 배열.
                    // 이 앱 내의 alert에서 텍스트 필드를 하나 밖에 추가하지 않았기 때문에 0번째 인덱스로 배열에 접근해서 텍스트 필드에 접근되도록 하였다.
                    // text 프로퍼티를 이용해서 텍스트 필드에 입력된 값이 무었인지 가져오게 코드를 작성.
            debugPrint("\(alert.textFields?[0].text)")
            
            // tasks 배열에 할 일이 추가 되게 코드를 작성.
            guard let title = alert.textFields?[0].text else { return }
            
            // Task 구조체를 인스턴스화
                // title 에는 할 일을 전달
                // done 에는 아직 할 일이 끝나지 않았으니 false를 전달하여 초기화
            let task = Task(title: title, done: false)
            // 등록 버튼을 누르면 tasks 배열에 할 일들이 추가된다.
            self?.tasks.append(task)
            
            // tasks 배열에 할 일이 추가될 때마다 테이블 뷰를 갱신해서 테이블 뷰에 추가된 할 일이 표시되게 구현
            self?.toDoListTableView.reloadData()
        }
        
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(cancelButton)
        alert.addAction(registerButton)
        
        // alert에 textField를 추가.
            // configurationHandler 파라미터에는 클로저를 받는다.
            // configurationHandler는 alert을 표시하기 전에 textField를 구성하기 위한 클로저.
            // 이 클로저는 반환값이 없고 textField 객체에 해당하는 단일 매개변수를 사용한다.
                // 즉, alert에 표시하는 textField를 설정하는 클로저라고 생각하면 된다.

        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "할 일을 입력해주세요."
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    // UserDefault에 할 일을 저장하는 method
    func saveTasks() {
        // 할 일들을 UserDefaults에 Dictionary 형태의 Array로 저장
            // 배열에 있는 요소들을 Dictionary 형태로 매핑
        let data = self.tasks.map {
            [
                // Key는 title, Value로는 tasks 인스턴스의 title 프로퍼티를 넣어준다.
                "title" : $0.title,
                
                // Key는 done, Value로는 tasks 인스턴스의 done 프로퍼티를 넣어준다.
                "done" : $0.done
            ]
        }
        
        // UserDefaults.standard로 UserDefaults에 접근할 수 있도록 선언.
            // UserDefaults는 Singleton이므로 하나의 인스턴스만 존재할 수 있다.
        let userDefaults = UserDefaults.standard
        
        // UserDefaults에 데이터 저장하는 방법은 set 메소드를 이용하여 저장한다.
            // UserDefaults는 Key, Value 쌍으로 저장된다.
                // 따라서 첫 번째 파라미터에는 Value 값을 넣어주고, 두 번째 파라미터에는 Key 값을 넣어주면 된다.
                    // 여기서 첫 번째 파라미터에는 Value 값인 data를 넣어주고, Key 값에는 내가 정의한 키 값을 넣어준다.
        userDefaults.set(data, forKey: "tasks")
    }
    
    // UserDefault에 저장된 데이터를 로드하는 method
    func loadTasks() {
        // UserDefaults에 접근하는 코드.
        let userDefaults = UserDefaults.standard
        
        // object 메소드로 UserDefault에 저장된 데이터를 가져올 수 있다.
            // forKey 파라미터에는 data를 저장할 때 설정한 Key를 넣어주면 된다.
            // objcet 메소드는 Any 타입으로 return 되기 때문에 Dictionary 형태의 Array로 저장했으니 Dictionay 형태의 Array로 type casting 해야 한다.
                // type casting에 실패시 nil이 될 수 있으므로 guard 문으로 옵셔널 바인딩을 해준다.
        guard let data = userDefaults.object(forKey: "tasks") as? [[String: Any]] else { return }
        
        // 다시 tasks에 저장하기 위해 data.compactMap으로 tasks 타입 배열이 되도록 매핑한다.
        self.tasks = data.compactMap({ dictinaryData in
            // "title" key로 dictionary의 value를 가져온다
            // dictionary의 value가 any type이므로 string type으로 type casting
            guard let title = dictinaryData["title"] as? String else { return nil }
            
            // "done" key로 dictionary의 value를 가져온다.
            // dictionary의 value가 any type 이므로 done의 타입인 Bool type으로 type casting
            guard let done = dictinaryData["done"] as? Bool else { return nil }
            
            // Task type이 되게 인스턴스화 한다.
            return Task(title: title, done: done)
        })
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.toDoListTableView.dequeueReusableCell(withIdentifier: ToDoListTableViewCell.identifier, for: indexPath) as? ToDoListTableViewCell else {
            return UITableViewCell()
        }
        
        let task = self.tasks[indexPath.row]
        cell.textLabel?.text = task.title
        
        // done 프로퍼티가 true일 경우 셀의 악세사리 타입이 체크 마크가 되도록, false일 경우 none
        if task.done {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    // 편집모드에서 삭제 버튼을 눌렀을 때 삭제 버튼이 눌러진 셀이 어떤 셀인지 알려주는 메서드
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 삭제 버튼이 눌러진 행이 삭제 되도록 구현.
        
        //remove(at:)에 indexPath.row를 넘겨줘서 선택 된 셀이 tasks 배열에서 삭제되도록 한다.
        self.tasks.remove(at: indexPath.row)
        
        // deleteRow(at:with:)에서 at에 삭제된 셀에 indexPath 정보를 넘겨줘서 테이블 뷰에도 할 일이 삭제되도록 구현한다.
        // 다음과 같이 구현했을 경우 삭제버튼을 눌렀을 때 셀이 테이블 뷰에서 삭제되고 편집모드에 안들어가도 스와이프 delete로 삭제가 가능하다.
        self.toDoListTableView.deleteRows(at: [indexPath], with: .automatic)
        
        // tasks가 비어있다면 didTapDoneButton을 호출하여 편집모드를 빠져나오게 구현
        if self.tasks.isEmpty {
            self.didTapDoneButton(nil)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 행이 다른 위치로 이동하면 sourceIndexPath 파라미터를 통해 원래 있었던 위치를 알려준다.
    // destinationIndexPath 파라미터를 통해 어디로 이동 했는지 알려준다
        // 그래서 이 두가지 파라미터를 이용하면 셀을 재정렬 할 수 있다.
            // 만약 첫 번째 셀이 세 번로 이동한다면 sourceIndexPath 파라미터는 원래 있었던 0번째 셀이라고 알려줄 것 이고, destinationIndexPath 파라미터는 세 번째 셀로 이동했다고 알려줄 것 이다.
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // 테이블 뷰를 재정렬시 할 일을 저장하는 배열도 재정렬 해야 하므로 이 메서드 안에서 테이블 뷰 셀이 재정렬된 순서대로 배열도 재정렬 되도록 구현.
        
        // 변수 tasks를 정의하여 self.tasks를 선언해서 가져오도록 한다.
        var tasks = self.tasks
        
        // 배열의 요소로 접근하는 코드
        let task = tasks[sourceIndexPath.row]
        
        // 원래의 위치에 있던 할 일을 삭제
        tasks.remove(at: sourceIndexPath.row)
        
        // insert를 이용해 newElement에는 배열에 접근한 할 일을 넘겨주고 at 파라미터에는 이동한 위치인 destinationIndexPath.row를 넘겨준다.
        tasks.insert(task, at: destinationIndexPath.row)
        
        // self.tasks에 재정렬된 배열인 tasks를 넣어줘서 할 일 배열도 재정렬되게 구현
        self.tasks = tasks
    }
}

extension ViewController: UITableViewDelegate {
    // didSelectRowAt 메소드
        // 셀을 선택하였을 때 어떤 셀이 선택 되었는지 알려주는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // tasks 배열의 요소에 접근해서 Task 인스턴스의 done 프로퍼티가 true이면 false가 되게, false면 true가 되게 코드를 만든다.
            // tasks[indexPath.row]로 배열의 요소에 접근
                // 만약 첫 번째 셀을 선택시 indexPath.row가 0, 두 번째 셀을 선택시 indexPath.row는 1이 될 것이다.
        var tasks = self.tasks[indexPath.row]
        tasks.done = !tasks.done
        
        // 변경된 task를 self.tasks[indexPath.row]로 원래의 배열의 요소로 덮어 씌운다.
        self.tasks[indexPath.row] = tasks
        
        // reloadRow 메소드를 호출해 선택된 셀만 리로드 되게 만들어준다.
        
            // at 파라미터에는 섹션과 행의 위치의 정보를 담은 IndexPath 구조체의 배열을 넘겨준다.
                // 배열을 받는다는것은 단일 행 뿐만 아니라 여러 개의 특정 행을 업데이트 할 수 있다는 뜻.
            // 이 앱에서는 선택된 셀만 리로드 되게 만들면 되므로 배열에 선택된 셀의 indexPath의 정보를 넘겨준다.
        
            // with 파라미터에는 RowAnimation이라는 열거형 타입을 받는다.
                // 행이 업데이트 될 때 어떤 애니매이션을 보여줄지 지정할 수 있는 타입이다.
                // 예를 들면 열거형 타입에 따라 삽입, 삭제가 일어날 시 좌측.우측 등으로 이동하면서 사라지거나 추가되도록 설정할 수 있다.
                    // c.f _ .automatic은 system이 알아서 선택하도록 하는 애니메이션 열거형 타입.
        self.toDoListTableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
