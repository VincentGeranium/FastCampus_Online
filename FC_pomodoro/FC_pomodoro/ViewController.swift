//
//  ViewController.swift
//  FC_pomodoro
//
//  Created by Morgan Kang on 2022/01/22.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    let pomodoroImageView: PomodoroImageView = {
        let imageView: PomodoroImageView = PomodoroImageView(frame: .zero)
        return imageView
    }()
    
    let pomodoroTimerLabel: PomodoroTimerLabel = {
        let label: PomodoroTimerLabel = PomodoroTimerLabel(frame: .zero)
        label.alpha = 0
        return label
    }()
    
    let pomodoroProgressView: PomodoroProgressView = {
        let progressView: PomodoroProgressView = PomodoroProgressView(frame: .zero)
        progressView.alpha = 0
        return progressView
    }()
    
    let pomodoroDatePicker: PomodoroDatePicker = {
        var datePicker: PomodoroDatePicker = PomodoroDatePicker(frame: .zero)
        return datePicker
    }()
    
    let pomodoroButtonStackView: PomodoroButtonStackView = {
        let stackView: PomodoroButtonStackView = PomodoroButtonStackView(frame: .zero)
        
        [stackView.cancelButton,
         stackView.toggleButton].forEach { buttons in
            stackView.addArrangedSubview(buttons)
        }
        
        return stackView
    }()
    
    // 타이머에 저장된 시간을 초로 저정하는 프로퍼티.
        // duration을 60으로 초기화한 이유는 datepicker가 기본적으로 처음 시작하면 1분으로 시작하기 때문이다.
    var duration = 60
    
    // TimerStatus type의 프로퍼티 정의
        // 타이머의 상태를 가지고 있는 프로퍼티.
            // 타이머가 시작된 상태면 start의 열거형 값을 갖고, 일시정지 상태면 pasue의 열거형 값을 갖고, 끝나면 end의 열거형 값을 갖게 된다.
    var timerStatus: TimerStatus = .end
    
    // DispatchSourceTimer 타입의 프로퍼티 정의
    var timer: DispatchSourceTimer?
    
    // 현재 카운트 다운되고 있는 시간을 저장하는 프로퍼티
    var currentSeconds = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupPomodoroImageView()
        setupPomodoroTimerLabel()
        setupPomodoroProgressView()
        setupPomodoroDatePicker()
        setupPomodoroButtonStackView()
        configureButtons()
    }
    
    private func setupPomodoroImageView() {
        let guide = self.view.safeAreaLayoutGuide
        
        pomodoroImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(pomodoroImageView)
        
        NSLayoutConstraint.activate([
            pomodoroImageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 24),
            pomodoroImageView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            pomodoroImageView.widthAnchor.constraint(equalToConstant: 100),
            pomodoroImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func setupPomodoroTimerLabel() {
        let guide = self.view.safeAreaLayoutGuide
        
        pomodoroTimerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(pomodoroTimerLabel)
        
        NSLayoutConstraint.activate([
            pomodoroTimerLabel.topAnchor.constraint(equalTo: self.pomodoroImageView.bottomAnchor, constant: 80),
            pomodoroTimerLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 24),
            pomodoroTimerLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -24)
        ])
    }
    
    private func setupPomodoroProgressView() {
        let guide = self.view.safeAreaLayoutGuide
        
        pomodoroProgressView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(pomodoroProgressView)
        
        NSLayoutConstraint.activate([
            pomodoroProgressView.topAnchor.constraint(equalTo: pomodoroTimerLabel.bottomAnchor, constant: 30),
            pomodoroProgressView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 48),
            pomodoroProgressView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -48)
        ])
    }
    
    private func setupPomodoroDatePicker() {
        let guide = self.view.safeAreaLayoutGuide
        
        pomodoroDatePicker.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(pomodoroDatePicker)
        
        NSLayoutConstraint.activate([
            pomodoroDatePicker.topAnchor.constraint(equalTo: pomodoroImageView.bottomAnchor, constant: 30),
            pomodoroDatePicker.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            pomodoroDatePicker.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
        ])
    }
    
    private func setupPomodoroButtonStackView() {
        let guide = self.view.safeAreaLayoutGuide
        
        pomodoroButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(pomodoroButtonStackView)
        
        NSLayoutConstraint.activate([
            pomodoroButtonStackView.topAnchor.constraint(equalTo: pomodoroDatePicker.bottomAnchor, constant: 24),
            pomodoroButtonStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 24),
            pomodoroButtonStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -24),
        ])
    }
    
    private func configureButtons() {
        pomodoroButtonStackView.cancelButton.addTarget(self, action: #selector(tapCancelButton(_:)), for: .touchUpInside)
        pomodoroButtonStackView.toggleButton.addTarget(self, action: #selector(tapToggleButton(_:)), for: .touchUpInside)
    }
    
    // timer setup and start method
    // 타이머의 셋팅과 시작 메서드
    func startTimer() {
        if self.timer == nil {
            // queue 파라미터에는 어떤 thread queue에서 반복 동작 할 것인지 설정.
                // 이 앱에서는 타이머가 돌 때마다 UI 동작을 해줘야 한다.
                    // 예를 들어 남은 시간을 표현해주는 Label을 표시해줘야 하고, prgressView도 update 해줘야한다.
                        // 때문에 main thread에서 반복 동작하게 해야한다.
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            
            // 어떤 주기로 타이머를 실행할 것인지 schedule 메소드를 이용하여 설정한다.
                // deadline 파라미터에는 .now를 전달하여 타이머가 실행되면 즉시 실행되도록 하게 한다.
                    // 참고로 3초 뒤에 실행되게 만들고 싶다면 '.now() + 3'을 할당해주면 된다.
                // repeating 파라미터에는 몇 초마다 반복되게 할 것인지 설정
                    // 1을 할당시 1초마다 반복되게 설정
            self.timer?.schedule(deadline: .now(), repeating: 1)
            
            // timer와 함께 연동된 이벤트 핸들러를 할당.
                // handler 파라미터에 클로저를 할당해주면 된다.
                    // 타이머가 동작할 때마다 클로저 핸들러 함수가 호출되게 된다.
                        // 즉, 위에서 1초에 한번씩 반복되게 했음므로 아래의 핸들러 클로저는 1초에 한번씩 호출되게 된다고 생각하면 된다.
                            // [weak self] in으로 캡쳐 목록을 정의
            self.timer?.setEventHandler(handler: { [weak self] in
                // datePicker에서 설정한 시간을 countdown 시키는 로직.
                
                // self가 일시적으로 strong reference가 되게 만듦.
                guard let self = self else { return }
                
                    // 1초씩 currentSeconds를 감소시킴.
                self.currentSeconds -= 1
                
                // 초를 시, 분, 초로 바꾼다.
                let hour = self.currentSeconds / 3600
                let minutes = (self.currentSeconds % 3600) / 60
                let seconds = (self.currentSeconds % 3600) % 60
                
                self.pomodoroTimerLabel.text = String(format: "%02d:%02d:%02d", hour, minutes, seconds)
                
                // countdown되고 있는 시간(self.currentSeconds)을 datePicker에서 설정한 시간(self.duration)으로 나누어 준다.
                    // 카운트 다운 될 때마다 프로그레스 뷰의 게이지가 줄어든다
                    // progress는 float 타입으로 대입해야한다.
                        // 카운트 다운되고 있는 시간을 타이머에 설정된 시간으로 나누면 프로그레스 뷰의 게이지가 0에 가까워지기 때문에 점점 줄어들게 된다.
                self.pomodoroProgressView.progress = Float(self.currentSeconds) / Float(self.duration)
                
                // delay라는 파라미터에는 에니메이션을 몇 초 뒤에 동작 시킬 것인지 delay 시간을 설정.
                    // 여기서는 0초를 넣어서 바로 애니메이션이 동작하도록 함
                UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                    // imageView의 transform 프로퍼티를 이용하여 이미지에 변환을 줌
                        // CGAffineTransform의 rotationAngle에 pi 값을 넣어주어 180도로 이미지가 회전되도록 만들어준다.
                    self.pomodoroImageView.transform = CGAffineTransform(rotationAngle: .pi)
                }, completion: nil)
                
                // delay 파라미터에 0.5를 넣어주어 180도 회전이 끝나면 360도 회전이 되도록한다.
                UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
                    // CGAffineTransform의 rotationAngle에 pi * 2값을 넣어주어 360도로 이미지가 회전되도록 만들어준다.
                    self.pomodoroImageView.transform = CGAffineTransform(rotationAngle: .pi *  2)
                }, completion: nil)
                
                if self.currentSeconds <= 0 {
                    // 타이머가 종료
                    self.stopTimer()
                    // 아이폰 기본 시스템 소리가 울리게 한다.
                        // 함수의 파라미터에는 시스템 사운드의 아이디를 넣어주면 된다.
                        // 이 파라미터는
                    AudioServicesPlaySystemSound(1005)
                }
            })
            // resume 메서드를 호출해서 timer가 시작되도록 한다.
            self.timer?.resume()
        }
    }
    
    // timerStatus를 end로 바꾸고 view를 갱신하는 로직을 작성.
    func stopTimer() {
    // ‼️ suspend 된 타이머는 아직 할 작업이 있다는 뜻 이므로 nil을 대입시 runtime error이 발생할 수 있다.
        // 때문에 일시정지 된 상태에서 nil을 대입하려면 그 전에 resume 메서드를 호출하라고 문서에 적혀져있다.
        if self.timerStatus == .pause {
            self.timer?.resume()
        }
        
        self.timerStatus = .end
        // cancel button 비활성화
        self.pomodoroButtonStackView.cancelButton.isEnabled = false
        self.pomodoroButtonStackView.cancelButton.setTitleColor(.systemGray, for: .normal)
        UIView.animate(withDuration: 0.5) {
            self.pomodoroTimerLabel.alpha = 0
            self.pomodoroProgressView.alpha = 0
            self.pomodoroDatePicker.alpha = 1
            // identity 값을 넣어주어 원래의 이미지 값으로 돌려넣어준다.
            self.pomodoroImageView.transform = .identity
        }
        // toggle 버튼의 title이 시작이 되게 만들어준다.
        self.pomodoroButtonStackView.toggleButton.isSelected = false
        // 타이머 취소 메서드 호출
        self.timer?.cancel()
        // 타이머에 nil을 할당하여 메모리에서 해제시킴.
            // ‼️ 타이머를 종료할 때 꼭 nild을 할당하여 메모리에서 해제시켜줘야 한다.
                // 그렇지 않을 경우 화면을 벗어나도 타이머가 계속해서 동작할 수 있다.
        self.timer = nil
    }
    
    func setTimerInfoViewVisible(isHidden: Bool) {
        self.pomodoroTimerLabel.isHidden = isHidden
        self.pomodoroProgressView.isHidden = isHidden
    }
    
    @objc func tapCancelButton(_ sender: UIButton) {
        switch timerStatus {
            // timer가 start나 pause 상태이면
        case .start, .pause:
            self.stopTimer()
        default:
            break
        }
        
    }
    
    @objc func tapToggleButton(_ sender: UIButton) {
        self.duration = Int(self.pomodoroDatePicker.countDownDuration)
        
        // toggle button을 누를 경우 timerStatus 값을 바꿔줘야 한다.
        switch timerStatus {
        case .end:
            // currentSeconds에 datePicker의 countdown 시간인 duration을 대입
            self.currentSeconds = self.duration
            // 타이머의 상태를 start로 바꿔준다.
            self.timerStatus = .start
            // animate 메서드를 이용해 animation을 구현.
                // withDuration 파라미터에는 animation을 몇 초 동안 지속할 것인지 설정
                // animations 파라미터에는 closure를 구현해준다
                    // 이 클로저에 원하는 최종 값을 설정하면 현재 값에서 최종 값으로 변하는 애니메이션이 실행된다.
            UIView.animate(withDuration: 0.5) {
                // alpha 값을 1로 설정하여 보여지게 만든다.
                self.pomodoroTimerLabel.alpha = 1
                self.pomodoroProgressView.alpha = 1
                // alpha 값을 0으로 설정하여 투명하게 만든다.
                self.pomodoroDatePicker.alpha = 0
            }
            
            // toggle button의 상태를 select 상태로 바꿔준다.
            self.pomodoroButtonStackView.toggleButton.isSelected = true
            // 취소 버튼이 활성화되게 만든다.
            self.pomodoroButtonStackView.cancelButton.isEnabled = true
            self.pomodoroButtonStackView.cancelButton.setTitleColor(.systemBlue, for: .normal)
            self.startTimer()
        case .start:
            self.timerStatus = .pause
            self.pomodoroButtonStackView.toggleButton.isSelected = false
            // 타이머를 일시정지 시킴 -> suspend() 메서드 사용
                // ‼️ suspend 된 타이머는 아직 할 작업이 있다는 뜻 이므로 nil을 대입시 runtime error이 발생할 수 있다.
                    // 때문에 일시정지 된 상태에서 nil을 대입하려면 그 전에 resume 메서드를 호출하라고 문서에 적혀져있다.
            self.timer?.suspend()
        case .pause:
            self.timerStatus = .start
            self.pomodoroButtonStackView.toggleButton.isSelected = true
            // 타이머를 다시 시작 시킴 -> resume() 메서드 사용.
            self.timer?.resume()
        default:
            break
        }
    }

}

