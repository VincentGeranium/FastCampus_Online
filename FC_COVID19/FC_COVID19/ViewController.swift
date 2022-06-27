//
//  ViewController.swift
//  FC_COVID19
//
//  Created by Morgan Kang on 2022/01/26.
//

import UIKit
import Charts
import Alamofire

class ViewController: UIViewController {
    let indicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(frame: .zero)
        return activityIndicatorView
    }()
    
    let covidLabelStackView: CovidLabelStackView = {
        let stackView: CovidLabelStackView = CovidLabelStackView(frame: .zero)
        
        [stackView.confirmPatientStackView,
         stackView.newConfirmPatientStackView].forEach { views in
            stackView.addArrangedSubview(views)
        }
        stackView.isHidden = true
        return stackView
    }()
    
    let covidPieChartView: ChartView = {
        let chartView: ChartView = ChartView(frame: .zero)
        chartView.isHidden = true
        return chartView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupCovidLabelStackView()
        setupCovidPieChartView()
        setupIndicatorView()
        
        // 인디케이터 시작
        self.indicatorView.startAnimating()
        
        self.fetchCovidOverView { [weak self] result in
            // 일시적으로 self가 Strong reference가 되도록 만든다.
            guard let self = self else { return }
            // 서버에서 응답이 왔기 때문에 인디케이터가 정지한다.
            self.indicatorView.stopAnimating()
            // 인디케이터를 사라지게 만든다.
            self.indicatorView.isHidden = true
            // 숨겨져있던 stackView와 Chart를 보이게 만든다.
            self.covidLabelStackView.isHidden = false
            self.covidPieChartView.isHidden = false
            
            switch result {
            case let .success(result):
                // configureStackView 메소드의 파라미터 값으로 result.korea를 넘겨줘서 label에 국내 총 확진자 수와 국내 신규 확진자 수가 표시되게 구현.
                self.configureStackView(koreaCovidOverview: result.korea)
                // makeCovidOverviewList 메서드의 파라미터로 메서드의 반환값이 저장되게 만들어준다
                let covidOverviewList = self.makeCovidOverviewList(cityCovidOverview: result)
                // 메서드의 파라미터로 covidOverviewList를 넘겨준다
                self.configureChartView(covidOverviewList: covidOverviewList)
            case let .failure(error):
                debugPrint("error : \(error)")
            }
        }
    }
    
    func setupIndicatorView() {
        let guide = self.view.safeAreaLayoutGuide
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
        ])
    }
    
    private func setupCovidLabelStackView() {
        let guide = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(covidLabelStackView)
        
        covidLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            covidLabelStackView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 24),
            covidLabelStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 24),
            covidLabelStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -24),
        ])
    }
    
    private func setupCovidPieChartView() {
        let guide = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(covidPieChartView)
        
        covidPieChartView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            covidPieChartView.topAnchor.constraint(equalTo: covidLabelStackView.bottomAnchor, constant: 24),
            covidPieChartView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 24),
            covidPieChartView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -24),
            covidPieChartView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -24),
        ])
    }
    // fetchCovidOverView 메소드 파라미터에는 completionHandler 클로저를 전달 받는다.
        // API를 요청하고 서버에서 JSON 데이터를 응답 받거나 요청에 실패하였을 때 이 completionHandler 클로저를 호출
            // 해당 클로저를 정의하는 곳에 응답 받은 데이터를 전달한다.
    // Result<>에서 첫 번째 제네릭 즉, 요청애 성공시 cityCovidOverview 열거형 연관값을 받을수 있도록 만들어 준다.
    // 두 번째 제네릭에는 failer, 요청에 실패하거나 에러사항시 Error 객체가 열거형 연관값으로 전달되게 만든다
    func fetchCovidOverView(completionHandler: @escaping (Result<CityCovidOverview,Error>) -> Void) {
        // url 상수 선언 -> 시도별 발생 동향 API 주소를 넣어준다.
        let url = "https://api.corona-19.kr/korea/country/new/"
        // param 상수 선언 -> 딕셔너리 대입.
            // 딕셔너리 키에는 "serviceKey"이고 값에는 발급받은 API 키값을 넣어준다.
        let param = [
            "serviceKey": "acHf7Z2V6konRXGsWJ8lYPOewyCLQtNm5"
        ]
        
        // Alamofire를 이용하여 해당 API를 호출하기.
            // request 메서드를 이용하기.
                // 첫 번째 파라미터에는 url
                // 두 번째 파라미터에는 GET 방식으로 요청할 것이므로 .get
                // 세 번째 파라미터에는 요청할 쿼리 파라미터를 넣어준다. -> param
                    // 딕셔너리 형태로 파라미터에 전달시 알아서 url 뒤에 쿼리 파라미터를 추가해준다.
        // request 메소드가 완성되었으면 응답 데이터를 받을 수 잇는 메서드를 체이닝 해줘야 한다.
            // responseData 메소드를 사용한다.
                // completionHandler를 정의를 해주면 응답 데이터가 클로저의 파라미터로 전달되게 된다.
        AF.request(url, method: .get, parameters: param, encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: nil).responseData { responseData in
            // 요청에 대한 응답 결과는 result 프로퍼티로 알 수 있다.
                // 열거형으로 되어있기 때문에 switch 문을 활용한다.
            switch responseData.result {
                // 요청 결과가 success이면 연관값으로 서버에서 응답받은 data가 전달된다
                // success 구문 안에 응답 받은 JSON 데이터를 cityCovidoverview에 매핑되도록 구현한다.
            case let .success(data):
                // do-catch 구문 활용
                do {
                    // decoder 상수 선언. -> JSONDecoder 인스턴스 대입
                    let decoder = JSONDecoder()
                    // result 상수 선언 -> decoder의 decode 사용
                        // 첫 번째 파라미터에는 매핑할 객체 타입을 넣어준다.
                        // 두 번째 파라미터에는 받아온 데이터를 넣어준다.
                    let result = try decoder.decode(CityCovidOverview.self, from: data)
                    // fetchCovidOverView 함수의 completionHandler 호출.
                        // success 열거형 값 연관값에 서버에서 응답받은 JSON 데이터가 맵핑된 CityCovidOverview 객체를 넘겨준다.
                    completionHandler(.success(result))
                } catch {
                    // 만약 JSON 데이터가 CityCovidOverview 객체로 맵핑하는데 실패시 catch 구문이 실행된다.
                        // completionHandler 파라미터에 failure 열거형 값을 전달 -> 연관값에는 error을 넘겨준다.
                    completionHandler(.failure(error))
                }
                // 요청 실패시 연관값으로 error 객체를 전달받을 수 있도록 구현
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func configureStackView(koreaCovidOverview: CovidOverview) {
        self.covidLabelStackView.confirmPatientStackView.contentsLabel.text = "\(koreaCovidOverview.totalCase) 명"
        self.covidLabelStackView.newConfirmPatientStackView.contentsLabel.text = "\(koreaCovidOverview.newCase) 명"
    }
    
    // 시도별 신규확진자 수를 pi차트에 표시하도록 구현.
        // 메서드 정의
        //-> 파라미터로 CityCovidOverview를 전달 받는다.
        //-> 반환 타입으로 [CovidOverview] 즉 CovidOverview 배열 타입.
            // 그러나 JSON 응답이 배열이 아닌 하나의 객체로 오기 때문에 CityCovidoverview 객체 안에있는 시도별 객체를 배열에 추가시키도록 구현한다.
    func makeCovidOverviewList(cityCovidOverview: CityCovidOverview) -> [CovidOverview] {
        return [
            cityCovidOverview.seoul,
            cityCovidOverview.busan,
            cityCovidOverview.daejeon,
            cityCovidOverview.incheon,
            cityCovidOverview.gwangju,
            cityCovidOverview.daegu,
            cityCovidOverview.ulsan,
            cityCovidOverview.sejong,
            cityCovidOverview.jeju,
            cityCovidOverview.gyeonggi,
            cityCovidOverview.chungbuk,
            cityCovidOverview.chungnam,
            cityCovidOverview.gyeongbuk,
            cityCovidOverview.gyeongnam,
        ]
    }
    
    // 파이 차트를 구성하는 메서드 정의.
        // 파이 차트에 데이터를 표시하려면 파이 차트 데이터 엔트리라는 객체에 데이터를 추가 시켜줘야한다.
        // 메서드 내에서 메서드 파라미터에서 전달받은 CovidOverview 배열을 파이 차트 데이터 엔트리 라는 객체로 맵핑시켜줘야 한다.
    func configureChartView(covidOverviewList: [CovidOverview]) {
        // 차트를 선택했을 때 covidDetailViewController가 push 되도록 구현.
            // delegate 선언
        self.covidPieChartView.delegate = self
        
        // entries 라는 상수 선언 -> compactMap으로 CovidOverview 객체를 파이 차트 데이터 엔트리 객체로 맵핑.
            // entries 상수에는 CovidOverview 객체에서 PieChartDataEntry 객체로 맵핑된 배열이 저장된다.
        let entries = covidOverviewList.compactMap { [weak self] covidOverview -> PieChartDataEntry? in
            // 일시적으로 self가 strong reference가 되도록 만들기.
            guard let self = self else { return nil }
            
            // PieChartDataEntry 객체로 맵핑하기 위해 PieChartDataEntry 인스턴스를 생성.
                // value 파라미터에는 차트 항목에 들어가는 값을 넣어주면 된다.
                // label 파라미터에는 파이 차트에 표시할 항목의 이름을 넣어준다
                // data 파라미터에는 시도별 상세 데이터를 가질 수 있도록 covidOverview를 넣어준다.
            return PieChartDataEntry(
                value: self.removeFormatString(string: covidOverview.newCase),
                label: covidOverview.countryName,
                data: covidOverview
            )
        }
        // 데이터 셋으로 항목을 묶어 준다.
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황.")
        // 항목간 간격을 1 피트 정도 간격으로 떨어지게 만든다
        dataSet.sliceSpace = 1
        // 항목 이름을 검정색으로 만든다
        dataSet.entryLabelColor = .black
        // 파이 차트 항목 안에 있는 값의 텍스트 색상을 검정색을 만든다.
        dataSet.valueTextColor = .black
        
        // 항목 이름을 파이차트 안에 표시되게 하지 않고 밖의 선으로 표시되도록 만든다.
        dataSet.xValuePosition = .outsideSlice
        // 밖으로 표시되는 항목의 이름이 가독성 있게 되도록 아래처럼 설정
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3
        
        // 그래프의 색상이 다양한 색상으로 표시되도록 구현
            // dataSet의 colors 배열에 ChartColorTemplates 객체에 정의 되어 있는 색상들을 추가.
        dataSet.colors = ChartColorTemplates.vordiplom() +
        ChartColorTemplates.colorful() +
        ChartColorTemplates.joyful() +
        ChartColorTemplates.liberty() +
        ChartColorTemplates.material() +
        ChartColorTemplates.pastel()
        
        self.covidPieChartView.data = PieChartData(dataSet: dataSet)
        
        // 그래프를 회전 시켜주는 코드. -> spin 메서드를 활용.
            // 80도 정도 파이 차트를 회전.
                // duration 파라미터에는 애니메이션 지속 시간을 설정.
                // fromAngle 파라미터에는 현재 앵글 각을 넣어준다.
                // toAngle 파라미터에는 현재 앵글 각에 + 80을 더해줘 현재 앵글에서 80도 정도 회전된 상태로 만들어준다
        self.covidPieChartView.spin(duration: 0.3, fromAngle: self.covidPieChartView.rotationAngle, toAngle: self.covidPieChartView.rotationAngle + 80)
    }
    
    // String 타입의 문자열을 Double 타입으로 바꿔주는 method
    func removeFormatString(string: String) -> Double {
        // formatter 상수에 NumerFormatter 인스턴스를 생성
        let formatter = NumberFormatter()
        // 3 자리마다 콤마를 찍어주는 문자열을 숫자로 바꿔줄 것이므로 numberStyle에 decimal을 넘겨준다.
        formatter.numberStyle = .decimal
        // from 파라미터에는 메서드 파라미터에서 전달받은 string 파라미터를 넣어준다
        // 후에 .doubleVaule를 이용하여 Double가 되도록 만들어준다.
        // 만약 nil 일 경우 0 이 되도록 한다.
        return formatter.number(from: string)?.doubleValue ?? 0
    }
}

extension ViewController: ChartViewDelegate {
    // 차트에서 항목 선택시 호출되는 메서드
        // entry 메서드 파라미터를 통해 선택된 항목에 저장된 데이터를 가져올 수 있다
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let covidDetailViewController = CovidDetailViewController()
        
        // 차트에서 항목이 선택되었을 때 CovidDetailViewController가 push 되도록 구현.
            // 차트에서 선택된 항목을 CovidOverview 객체로 다운 캐스팅 하여 covidOverview 상수에 저장.
        guard let covidOverview = entry.data as? CovidOverview else { return }
//        debugPrint(covidOverview)
        // CovidDetailViewController의 covidOverview 프로퍼티에 차트에서 선택된 covidOverview 데이터를 넘겨준다.
        covidDetailViewController.covidOverview = covidOverview
        
        self.navigationController?.pushViewController(covidDetailViewController, animated: true)
    }
}

