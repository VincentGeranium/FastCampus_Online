//
//  AssetSectionHeaderView.swift
//  FC_MyAsset
//
//  Created by Morgan Kang on 2022/03/02.
//

import SwiftUI

struct AssetSectionHeaderView: View {
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil) {
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .default))
                .foregroundColor(.accentColor)
            Divider()
                .frame(width: nil, height: 2, alignment: .center)
                .background(Color.primary)
                .foregroundColor(.accentColor)
        }
    }
}

struct AssetSectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AssetSectionHeaderView(title: "계좌")
    }
}
