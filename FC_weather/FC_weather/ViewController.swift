//
//  ViewController.swift
//  FC_weather
//
//  Created by Morgan Kang on 2022/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    let cityNameTextField: WeatherTextField = {
        let textField: WeatherTextField = WeatherTextField(frame: .zero)
        return textField
    }()
    
    let weatherButton: WeatherCustomButton = {
        let button: WeatherCustomButton = WeatherCustomButton(frame: .zero)
        button.setTitle("날씨 가져오기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(tapFetchWeatherButton(_:)), for: .touchUpInside)
        return button
    }()
    
    let weatherAllStackView: WeatherAllStackView = {
        let stackView: WeatherAllStackView = WeatherAllStackView(frame: .zero)
        
        [stackView.weatherInfoStackView,
         stackView.weatherTempStackView].forEach { views in
            stackView.addArrangedSubview(views)
        }
        
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupWeatherTextField()
        setupWeatherButton()
        setupWeatherAllStackView()
    }
    
    private func setupWeatherTextField() {
        let guide = self.view.safeAreaLayoutGuide
        
        cityNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(cityNameTextField)
        
        NSLayoutConstraint.activate([
            cityNameTextField.topAnchor.constraint(equalTo: guide.topAnchor, constant: 30),
            cityNameTextField.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 24),
            cityNameTextField.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -24),
            cityNameTextField.heightAnchor.constraint(equalToConstant: 34),
        ])
    }
    
    private func setupWeatherButton() {
        let guide = self.view.safeAreaLayoutGuide
        
        weatherButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(weatherButton)
        
        NSLayoutConstraint.activate([
            weatherButton.centerXAnchor.constraint(equalTo: cityNameTextField.centerXAnchor),
            weatherButton.topAnchor.constraint(equalTo: cityNameTextField.bottomAnchor, constant: 24),
        ])
    }
    
    private func setupWeatherAllStackView() {
        let guide = self.view.safeAreaLayoutGuide
        
        weatherAllStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(weatherAllStackView)
        
        NSLayoutConstraint.activate([
            weatherAllStackView.topAnchor.constraint(equalTo: weatherButton.bottomAnchor, constant: 50),
            weatherAllStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 24),
            weatherAllStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -24),
        ])
    }
    
    @objc private func tapFetchWeatherButton(_ sender: UIButton) {
        if let cityName = self.cityNameTextField.text {
            self.getCurrentWeather(cityName: cityName)
            
            // 버튼이 눌리면 키보드가 사라지게 만든다.
            self.view.endEditing(true)
        }
        print("did tap weather button.")
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getCurrentWeather(cityName: String) {
        // 200~299번대 range를 가진 successRange 상수 정의.
        let successRange = (200..<300)
        
        // URL 객체의 정의.
        // string 파라미터에는 호출할 API url을 넣어준다.
        // url 내의 q 파라미터에는 매서드에서 전달받은 cityName이 대입되도록 한다.
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=1aa9cbf647655f6c9726e80264b6e79c") else { return }
        
        // URLSession 에 해당 url을 넘겨줘서 API를 호출.
            // 먼저 SessionConfiguration을 결정후 Session 생성.
                // configuration 파라미터에 .default를 넣어 기본 URLSession이 되도록 만든다.
        let session = URLSession(configuration: .default)
        // session.dataTask로 데이터를 요청
            // with 파라미터에는 호출할 url을 넣어준다.
                // [weak self]로 캡쳐 리스트 작성 -> 순환 참조 해결.
        session.dataTask(with: url) { [weak self] data, response, error in
            // dataTask가 API를 호출하고 서버에서 응답이 오면 completionHandler closure가 호출이 된다.
                // closure 내의 data 파라미터에는 서버에서 응답받은 데이터가 전달된다.
                // response 파라미터에는 HTTP 헤더 및 상태 코드와 같은 응답 메타 데이터가 전달된다.
                // error 파라미터에는 요청을 실패하게 되면 error 객체가 전달되게 된다, 만약 요청에 성공시 nil이 반환된다.
            
            // 응답받은 JSON 데이터를 WeatherInformation 객체로 Decoding 되게 구현.
                // JSON 데이터는 data 파라미터에 전달이 된다.
            
            // data가 있고 error이 nil일 경우 다음 라인이 실행되도록 아래와 같이 코드를 구현.
            guard let data = data, error == nil else { return }
            
            // JSONDecoder 인스턴스 생성.
                // JSONDecoder는 JSON 객체에서 데이터 유형의 인스턴스로 decoding하는 객체
                    // 한마디로 Decodable 또는 Codable 프로토콜을 준수하는 사용자 정의 타입으로 변환시켜주는 역활을 한다.
            let decoder = JSONDecoder()
            
            // closure를 통해 전달 받은 response를 HTTPURLResponse로 다운캐스팅.
            // successRange.contains 파라미터에 response의 statusCode를 넘겨줘서 응답 받은 statusCode 몇 번대인지 확인
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                // statusCode가 200번대라면 성공한 것.
                // 첫 번째 파라미터에는 JSON을 맵핑 시켜줄 Codable protocol을 준수하는 사용자 정의 타입을 넣어준다.
                // 두 번째 파람미터에는 서버에서 응답 받은 JSON 데이터를 넣어주면 된다.
                // Decoding에 실패시 error을 던지기 때문에 try? 를 활용하여 구현해야 한다.
                guard let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data) else { return }
                
                // 네트워크 작업은 별도의 thread에서 진행되고 응답이 온다해도 자동으로 main thread로 돌아오지 않는다.
                    // 때문에 completionHandler closure에서 UI 작업을 한다면 main thread에서 작업을 할 수 있도록 만들어줘야 한다.
                DispatchQueue.main.async {
                    self?.weatherAllStackView.isHidden = false
                    // configureView method에 weatherInformation을 넘겨줘서 현재 날씨 정보가 뷰에 표시되도록 한다.
                    self?.configureView(weatherInformation: weatherInformation)
                }
            } else {
                // statusCode가 200번대가 아니라면 error 상황
                    // 서버에서 응답 받은 error JSON 데이터를 error 메세지 객체로 decoding
                guard let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) else { return }
                // alert는 메인 스레드에서 표시되게 해줘야 한다.
                DispatchQueue.main.async {
                    // 서버에서 전달 받은 메세지를 메서드의 파라미터로 전달한다.
                    self?.showAlert(message: errorMessage.message)
                }
            }
        }.resume()
    }
    
    func configureView(weatherInformation: WeatherInformation) {
        self.weatherAllStackView.weatherInfoStackView.cityNameLabel.text = weatherInformation.name
        // weatherInformation.weather에서 .first로 weather 배열의 첫 번째 요소가 weather 상수에 대입되게 한다.
        if let weather = weatherInformation.weather.first {
            // weater의 description이 weatherDescriptionLabel에 대입 되도록 구현.
            self.weatherAllStackView.weatherInfoStackView.weatherDescriptionLabel.text = weather.description
        }
        // 현재 온도를 표시
            // weatherInformation.temp.temp에는 절대값이 저장되어 있음므로 273.15를 빼줘서 섭씨 온도로 변환시켜준다.
            // 또한 정수형으로 표현하기 위해 Int형으로 변환시킨다
        self.weatherAllStackView.weatherTempStackView.weatherTempLabel.text = "\(Int(weatherInformation.temp.temp - 273.15))℃"
        
        // 최저 온도를 표시
            // weatherInformation.temp.minTemp는 절대값으로 저장되어 있으므로 273.15를 빼줘 섭씨 온도로 변환시켜준다
            // 또한 정수형으로 형 변환 시켜준다.
        self.weatherAllStackView.weatherTempStackView.weatherHighestAndLowestTempStackView.minTempLabel.text = "최저: \(Int(weatherInformation.temp.minTemp - 273.15))℃"
        self.weatherAllStackView.weatherTempStackView.weatherHighestAndLowestTempStackView.maxTempLabel.text = "최고: \(Int(weatherInformation.temp.maxTemp - 273.15))℃"
        
    }
    
    
}

