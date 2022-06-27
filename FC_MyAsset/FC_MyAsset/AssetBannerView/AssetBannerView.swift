//
//  AssetBannerView.swift
//  FC_MyAsset
//
//  Created by Morgan Kang on 2022/03/02.
//

import SwiftUI

struct AssetBannerView: View {
    let bannerList: [AssetBanner] = [
        AssetBanner(title: "공지사항", description: "추가된 공지사항을 확인하세요.", backgroundColor: .blue),
        AssetBanner(title: "주중 이벤트", description: "깜짝 주중 이벤트를 확인하세요.", backgroundColor: .red),
        AssetBanner(title: "신규회원 이벤트", description: "신규 회원에게는 추가 쿠폰을 드립니다.", backgroundColor: .gray),
        AssetBanner(title: "가을 이벤트", description: "가을 맞이 이벤트를 시작합니다.", backgroundColor: .brown),
    ]
    
    @State private var currentPage: Int = 0
    
    var body: some View {
        let bannerCards = bannerList.map { BannerCard(banner: $0)
        }
        
        ZStack(alignment: .bottomTrailing) {
            PageViewController(pages: bannerCards, currentPage: $currentPage)
            PageControl(numberOfPage: bannerList.count, currentPage: $currentPage)
                .frame(width: CGFloat(bannerCards.count * 18), height: nil)
                .padding(.trailing)
        }
    }
}

struct AssetBannerView_Previews: PreviewProvider {
    static var previews: some View {
        AssetBannerView()
            .aspectRatio(5/2, contentMode: .fit)
    }
}
