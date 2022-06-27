//
//  BannerCard.swift
//  FC_MyAsset
//
//  Created by Morgan Kang on 2022/03/01.
//

import SwiftUI

struct BannerCard: View {
    var banner: AssetBanner
    
    var body: some View {
        // 1
        Color(banner.backgroundColor)
            .overlay(
                VStack {
                    Text(banner.title)
                        .font(.title)
                    Text(banner.description)
                        .font(.subheadline)
                }
            )
        /*
        // 2
        ZStack {
            Color(banner.backgroundColor)
            VStack {
                Text(banner.title)
                    .font(.title)
                Text(banner.description)
                    .font(.subheadline)
            }
        }
         */
    }
}

struct BannerCard_Previews: PreviewProvider {
    static var previews: some View {
        let dummyData = AssetBanner(title: "공지사항", description: "추가된 공지사항을 확인하세요", backgroundColor: .gray)
        BannerCard(banner: dummyData)
    }
}
