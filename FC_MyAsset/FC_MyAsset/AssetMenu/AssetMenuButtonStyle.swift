//
//  AssetMenuButtonStyle.swift
//  FC_MyAsset
//
//  Created by Morgan Kang on 2022/02/28.
//

import SwiftUI

struct AssetMenuButtonStyle: ButtonStyle {
    let menu: AssetMenu
    
    func makeBody(configuration: Configuration) -> some View {
        return VStack {
            Image(systemName: menu.systemImageName)
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .padding([.leading, .trailing], 10)
            Text(menu.title)
                .font(.system(size: 12, weight: .bold, design: .default))
        }
        .padding()
        .foregroundColor(.blue)
        .background {
            Color.white
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
  
}

struct AssetMenuButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .center, spacing: 20) {
            Button("") {
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: .creditScore))
            
            Button("") {
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: .bankAccount))
            
            Button("") {
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: .investment))
            
            Button("") {
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: .loan))
        }
        .background {
            Color.gray.opacity(0.5)
        }
    }
}
