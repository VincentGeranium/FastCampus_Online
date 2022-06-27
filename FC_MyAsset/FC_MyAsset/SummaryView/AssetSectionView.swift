//
//  AssetSectionView.swift
//  FC_MyAsset
//
//  Created by Morgan Kang on 2022/03/03.
//

import SwiftUI

struct AssetSectionView: View {
    @ObservedObject var assetSection: Asset
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            AssetSectionHeaderView(title: assetSection.type.title)
            ForEach(assetSection.data) { asset in
                HStack {
                    Text(asset.title)
                        .font(.title)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(asset.amount)
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                Divider()
            }
        }
        .padding()
    }
}

struct AssetSectionView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyAssetData = Asset(
            id: 0,
            type: .bankAccount,
            data: [
                AssetData(id: 0, title: "농협은행", amount: "5,300,000"),
                AssetData(id: 1, title: "카카오뱅크", amount: "15,300,000"),
                AssetData(id: 2, title: "국민은행", amount: "23,300,000"),
            ]
        )
        
        AssetSectionView(assetSection: dummyAssetData)
    }
}
