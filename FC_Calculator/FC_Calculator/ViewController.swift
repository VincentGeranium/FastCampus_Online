//
//  ViewController.swift
//  FC_Calculator
//
//  Created by Morgan Kang on 2021/12/31.
//

import UIKit

enum Operation {
    case Plus
    case Minus
    case Divide
    case Times
    case Unknown
}

class ViewController: UIViewController {
    
    let resultLabel: ResultLabel = {
        let label: ResultLabel = ResultLabel()
        label.textColor = .white
        label.text = "0"
        label.font = .systemFont(ofSize: 40, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    let keyPadView: KeyPadView = {
        let view: KeyPadView = KeyPadView()
        return view
    }()
    
    let structGuide = Guide()
    
    // 이 프로퍼티는 계산기 버튼을 누를때 마다 resultLabel 에 표시되는 숫자를 가지는 프로퍼티
    var displayNumber = ""
    
    // 이 프로퍼티는 이전 계산 값을 저장하는 프로퍼티. 즉, 첫 번째 피연산자라고 생각하면 된다.
    var firstOperand = ""
    
    // 이 프로퍼티는 새롭게 입력되는 값을 저장하는 프로퍼티. 즉, 두 번째 피연산자.
    var secondOperand = ""
    
    // 계산의 결과값을 저장하는 프로퍼티.
    var result = ""
    
    // 이 프로퍼티는 현재 계산기에 어떤 연산자가 입력되었는지 알 수 있도록 연산자의 값을 저장하는 프로퍼티.
    var currentOperation: Operation = .Unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        setupResultLabel()
        setupKeyPadView()
        
        didTapNumbersButton()
        didTapACButton()
        didTapDotButton()
        didTapDivideButton()
        didTapTimesButton()
        didTapMinusButton()
        didTapPlusButton()
        didTapResultButton()
    }
    
    private func setupResultLabel() {
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: structGuide.guide(vc: self).topAnchor, constant: 24),
            resultLabel.leadingAnchor.constraint(equalTo: structGuide.guide(vc: self).leadingAnchor, constant: 24),
            resultLabel.trailingAnchor.constraint(equalTo: structGuide.guide(vc: self).trailingAnchor, constant: -24),
            resultLabel.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    private func setupKeyPadView() {
        keyPadView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(keyPadView)
        
        NSLayoutConstraint.activate([
            keyPadView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 24),
            keyPadView.leadingAnchor.constraint(equalTo: structGuide.guide(vc: self).leadingAnchor, constant: 24),
            keyPadView.trailingAnchor.constraint(equalTo: structGuide.guide(vc: self).trailingAnchor, constant: -24),
            keyPadView.bottomAnchor.constraint(equalTo: structGuide.guide(vc: self).bottomAnchor, constant: -24),
        ])
    }
    
    private func didTapNumbersButton() {
        self.keyPadView.allStackView.secondStackView.sevenButton.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
        self.keyPadView.allStackView.secondStackView.eightButton.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
        self.keyPadView.allStackView.secondStackView.nineButton.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
        
        self.keyPadView.allStackView.thirdStackView.fourButton.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
        self.keyPadView.allStackView.thirdStackView.fiveButton.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
        self.keyPadView.allStackView.thirdStackView.sixButton.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
        
        self.keyPadView.allStackView.fourthStackView.oneButton.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
        self.keyPadView.allStackView.fourthStackView.twoButton.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
        self.keyPadView.allStackView.fourthStackView.threeButton.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
        
        self.keyPadView.allStackView.fifthStackView.zeroButton.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)
    }
    
    private func didTapACButton() {
        self.keyPadView.allStackView.firstStackView.acButton.addTarget(self, action: #selector(tapClearButton(_:)), for: .touchUpInside)
    }
    
    private func didTapDotButton() {
        self.keyPadView.allStackView.fifthStackView.dotButton.addTarget(self, action: #selector(tapDotButton(_:)), for: .touchUpInside)
    }
    
    private func didTapDivideButton() {
        self.keyPadView.allStackView.firstStackView.divideButton.addTarget(self, action: #selector(tapDivideButton(_:)), for: .touchUpInside)
    }
    
    private func didTapTimesButton() {
        self.keyPadView.allStackView.secondStackView.timesButton.addTarget(self, action: #selector(tapTimesButton(_:)), for: .touchUpInside)
    }
    
    private func didTapMinusButton() {
        self.keyPadView.allStackView.thirdStackView.minusButton.addTarget(self, action: #selector(tapMinusButton(_:)), for: .touchUpInside)
    }
    
    private func didTapPlusButton() {
        self.keyPadView.allStackView.fourthStackView.plusButton.addTarget(self, action: #selector(tapPlusButton(_:)), for: .touchUpInside)
    }
    
    private func didTapResultButton() {
        self.keyPadView.allStackView.fifthStackView.resultButton.addTarget(self, action: #selector(tapResultButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapNumberButton(_ sender: UIButton) {
        // 1. 계산기에서 키패드를 누를때 마다 displayNumber 프로퍼티에 선택된 숫자들을 저장.
        // 2. resultLabel에 선택된 숫자들이 표시되도록 코드 작성.
        
        // 선택한 버튼의 title 값을 가져오기.
            // title 값이 숫자로 되어있어 숫자 값이 return 이 될 것 이다.
            // 그러므로 optional type -> guard문으로 optional binding
        guard let numberValue = sender.title(for: .normal) else { return }
        
        // 선택된 숫자값을 displayNumber 프로퍼티에 문자열로 계속해서 추가.
            // 숫자는 9자리 까지만 입력될 수 있도록 if문 작성.
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            // 추가된 문자열 프로퍼티인 displayNumber를 resultLabel에 표시.
            self.resultLabel.text = self.displayNumber
        }
        
    }
    
    @objc func tapClearButton(_ sender: UIButton) {
        // 1. AC 버튼을 눌렀을 때 모든 프로퍼티들을 초기값으로 초기화.
        // 2. resultLabel에 0이 나오게 한다.
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOperation = .Unknown
        self.resultLabel.text = "0"
        
    }
    
    @objc func tapDotButton(_ sender: UIButton) {
        // 숫자에 소수점이 추가 되도록 만드는 코드.
        
        // if문을 이용하여 소수점 포함 9자리까지 나오게 예외처리.
        // if문을 이용하여 중복으로 소수점이 찍히는 것을 방지.
            // 이 두 가지 조건을 만족해야 함.
        if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
            // displayNumber에 삼항연산자를 사용하여 소수점에 관한 로직 코드 작성
                // 1. displayNumber가 비어있을 경우 "0." 이 추가되도록 한다.
                // 2. displayNumber가 비어있지 않을 경우 displayNumber 뒤에 "."이 추가되도록 한다.
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            
            // resultLabel에 추가
            self.resultLabel.text = self.displayNumber
        }
    }
    
    @objc func tapDivideButton(_ sender: UIButton) {
        operation(.Divide)
    }
    
    @objc func tapTimesButton(_ sender: UIButton) {
        operation(.Times)
    }
    
    @objc func tapMinusButton(_ sender: UIButton) {
        operation(.Minus)
    }
    
    @objc func tapPlusButton(_ sender: UIButton) {
        operation(.Plus)
    }
    
    @objc func tapResultButton(_ sender: UIButton) {
        self.operation(self.currentOperation)
    }
    
    // 계산을 담당하는 함수 정의
        // 함수의 파라미터로는 Operation 열거형을 받는다.
    func operation(_ operation: Operation) {
        // 함수 파라미터에서 전달받은 연산자에 따라서 계산을 하고 계산된 결과값을 resultLabel에 표시되게 코드 작성.
            // 예를 들어 3과 +를 누르면 firstOperand에는 3이 저장되고 currentOperation 프로퍼티에는 plus 연산자가 저장이 되도록 로직을 짠다.
        
        if self.currentOperation != .Unknown {
            // if 구문을 이용하여 currentOperation이 unknown이 아니면 첫 번째 피연산자와 두 번째 피연산자를 연산해주는 로직을 구현.
            
            
            if !self.displayNumber.isEmpty {
                // displayNumber 프로퍼티가 비어있지 않을 경우 secondOperand 프로퍼티에 두 번째 입력값을 저장해준다.
                self.secondOperand = self.displayNumber
                
                // 결과값이 표시된 후에 다시 숫자를 선택시 새롭게 선택한 숫자가 resultLabel에 표시가 되어야 한다.
                    // 때문에 displayNumber를 빈 문자열로 초기화 시킨다.
                self.displayNumber = ""
                
                // 첫 번째 피연산자와 두 번째 피연산자를 double 형으로 변환시킨다.
                guard let firstOperand = Double(self.firstOperand) else { return }
                guard let secondOperand = Double(self.secondOperand) else { return }
                
                // switch 문으로 currentOperation 프로퍼티 값에 따라서 첫 번째 피연산자와 두 번째 피연산자를 연산하는 로직
                switch self.currentOperation {
                case .Plus:
                    // currentOperation이 Plus라면 firstOperand 값과 secondOperand 값을 더한 값을 result 에 저장
                    self.result = "\(firstOperand + secondOperand)"
                    
                case .Minus:
                    self.result = "\(firstOperand - secondOperand)"
                    
                case .Times:
                    self.result = "\(firstOperand * secondOperand)"
                    
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
                    
                default:
                    break
                }
                // 소수점에 대한 로직
                    // 결과값을 1로 나눈 나머지 값이 0이라면 Int형으로 바꾼다.
                    // 결과값을 1로 나눈 나머지 값이 0이 아니라면 Double 타입으로 보여진다.
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                
                // 기본적으로 계산기 앱은 연산자를 여러개 사용할 수 있기 때문에 연산의 결과값을 다시 첫번째 피연산자에 넣어서 다음 연산에 사용할 수 있게 해야 한다.
                    // 그러므로 첫 번째 피연산자에 결과값이 저장될 수 있게 firstOperand에 result 값을 저장한다.
                self.firstOperand = self.result
                
                // 결과값 표시
                self.resultLabel.text = self.result
            }
            // 함수의 파라미터로 전달한 operation을 currentOperation에 저장
            self.currentOperation = operation
        } else {
            // 계산기가 초기화된 상태에서 사용자가 첫 번째 피연산자와 연산자를 선택한 상태일테니 firstOperand 프로퍼티에는 displayNumber가 피연산자로 저장이 될 것이고, currentOperation 프로퍼티에는 선택한 연산자가 저장될 것이다. 그리고 displayNumber는 빈 문자열로 초기화 시키낟.
            self.firstOperand = self.displayNumber
            self.currentOperation = operation
            self.displayNumber = ""
        }
        
    }
    
}

