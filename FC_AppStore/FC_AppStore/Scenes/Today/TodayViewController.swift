//
//  TodayViewController.swift
//  FC_AppStore
//
//  Created by Morgan Kang on 2022/03/07.
//

import UIKit
import SnapKit
import CoreMedia
import Accelerate

final class TodayViewController: UIViewController {
    private var todayList: [Today] = []
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView: UICollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            TodayCollectionViewCell.self,
            forCellWithReuseIdentifier: TodayCollectionViewCell.reuseIdentifier
        )
        collectionView.register(TodayCollectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: TodayCollectionHeaderView.reuseIdentifier
        )
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        do {
            try fetchData()
        } catch {
            fatalError()
        }
    }
}

extension TodayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width - 32.0
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width - 32.0
        
        return CGSize(width: width, height: 100.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let value: CGFloat = 16.0
        
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let today = todayList[indexPath.item]
        let vc = AppDetailViewController(today: today)
        self.present(vc, animated: true, completion: nil)
    }
}

extension TodayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TodayCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? TodayCollectionViewCell
        else {
            return UICollectionViewCell ()
        }
        
        let today = todayList[indexPath.item]
        
        cell.setup(today: today)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TodayCollectionHeaderView.reuseIdentifier, for: indexPath) as? TodayCollectionHeaderView else { return UICollectionReusableView () }
        
        headerView.setupViews()
        
        return headerView
    }
}

private extension TodayViewController {
    enum FetchError: Error {
        case badURLError
        case dataError
        case parsingError
    }
    
    func fetchData() throws {
        do {
            guard let url = Bundle.main.url(forResource: "Today", withExtension: "plist") else { throw FetchError.badURLError }
            guard let data  = try? Data(contentsOf: url) else { throw FetchError.dataError }
            guard let result = try? PropertyListDecoder().decode([Today].self, from: data) else { throw FetchError.parsingError}
            todayList = result
        } catch FetchError.badURLError {
            print("Bad URL")
        } catch FetchError.dataError {
            print("Data not found")
        } catch FetchError.parsingError {
            print("Paring error")
        }
    }
}
