//
//  HomeViewController.swift
//  FC_Netflix
//
//  Created by Morgan Kang on 2022/02/17.
//

import Foundation
import UIKit
import SwiftUI

class HomeViewController: UICollectionViewController {
    // 빈 Content 타입 배열 선언
    var contents: [Content] = []
    
    // mainItem 변수 선언
    var mainItem: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션 설정
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // 투명하지만 약간 그늘을 지게 만들어 경계를 알 수 있도록하는 코드
        navigationController?.navigationBar.shadowImage = UIImage()
        // tabelView나 collectionView 처럼 scroll로 해서 swipe action이 일어났을 경우, navigationBar를 가리는 효과를 주는 코드.
        navigationController?.hidesBarsOnSwipe = true
        
        // 왼쪽과 오른쪽에 네비게이션 버튼 추가
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "netflix_icon"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
        
        // 데이터 설정, 가져오기
        contents = getContents()
        mainItem = contents.first?.contentItem.randomElement()
        
        // CollectionView Item(cell) 설정
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.reuseIdentifire)
        collectionView.register(ContentCollectionViewRankCell.self, forCellWithReuseIdentifier: ContentCollectionViewRankCell.reuseIdentifire)
        collectionView.register(ContentCollectionViewMainCell.self, forCellWithReuseIdentifier: ContentCollectionViewMainCell.reuseIdentifier)
        // Header 설정
        collectionView.register(ContentCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ContentCollectionViewHeader.reuseIdetifier)
        
        // collectionView의 collectionViewLayout 설정
        collectionView.collectionViewLayout = layout()
    }
    
    func getContents() -> [Content] {
        // plist의 path 가져오기
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
              // FileManager를 이용해 path에 있는 Content.plist의 contents data가져오기
              let data = FileManager.default.contents(atPath: path),
              // PropertyListDecoder를 이용해 기본 property list format으로 decode한 특정한 타입의 Property list를 가져오기
                // 첫 번째 파라미터에는 내가 만든 특정한 타입을 넣어준다 -> 제공된 Property list에서 Decode하기 위한 값의 타입
                // 두 번째 파라미터에는 decode 하기 위한 property list를 넣어준다.
              let list = try? PropertyListDecoder().decode([Content].self, from: data) else { return [] }
        
        return list
    }
    
    // 각각의 section 타입에 대한 UICollectionViewLayout 생성.
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            switch self.contents[sectionNumber].sectionType {
            case .basic:
                return self.createBasicTypeSection()
            case .large:
                return self.createLargeTypeSection()
            case .rank:
                return self.createRankTypeSection()
            case .main:
                return self.createMainTypeSection()
            }
        }
    }
    
    // 기본 compositional layout 설정 함수
    private func createBasicTypeSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        // header
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    // 큰 화면 section layout 설정.
    private func createLargeTypeSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 0)
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        // header
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    // 순위 표시 section layout 설정.
    private func createRankTypeSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        // header
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    // Main Section layout 설정.
    private func createMainTypeSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(450))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        return section
    }
    
    // SectionHeader Layout 설정.
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        // Section Header Size
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        
        // Section Header Layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
    }
}

// UICollectionView DataSource, Delegate
extension HomeViewController {
    // 섹션당 보여질 셀의 갯수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return contents[section].contentItem.count
        }
    }
    
    // collectionView cell 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // collectionView cell 설정 코드 구현.
        switch contents[indexPath.section].sectionType {
        case .basic, .large:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.reuseIdentifire, for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() }
            
            // cell image 설정.
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            
            return cell
        case .rank:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewRankCell.reuseIdentifire, for: indexPath) as? ContentCollectionViewRankCell else { return UICollectionViewCell() }
            
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            cell.rankLabel.text = String(describing: indexPath.row + 1)
            
            return cell
        case .main:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewMainCell.reuseIdentifier, for: indexPath) as? ContentCollectionViewMainCell else { return UICollectionViewCell() }
            
            cell.imageView.image = mainItem?.image
            cell.descriptionLabel.text = mainItem?.description
            
            return cell
        }
    }
    
    // Header view 설정
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ContentCollectionViewHeader.reuseIdetifier, for: indexPath) as? ContentCollectionViewHeader else { fatalError("Could not dequeue Header") }
            headerView.sectionNameLabel.text = contents[indexPath.section].sectionName
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    // section 갯수 설정
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }
    
    // cell 선택
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let isFirstSection = indexPath.section == 0
        let selectedItem = isFirstSection ? mainItem : contents[indexPath.section].contentItem[indexPath.row]
        let contentDetailView = ContentDetailView(item: selectedItem)
        let hostingVC = UIHostingController(rootView: contentDetailView)
        
        self.show(hostingVC, sender: nil)
    }
}

// SwiftUI를 활용한 미리보기.
struct HomeViewController_priviews: PreviewProvider {
    static var previews: some View {
        HomeViewControllerRepresentable().preferredColorScheme(.dark).edgesIgnoringSafeArea(.all)
    }
}

struct HomeViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let layout = UICollectionViewLayout()
        let homeViewController = HomeViewController(collectionViewLayout: layout)
        return UINavigationController(rootViewController: homeViewController)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
}
