//
//  NavigationBarWithButton.swift
//  FC_MyAsset
//
//  Created by Morgan Kang on 2022/02/27.
//

import SwiftUI

struct NavigationBarWithButton: ViewModifier {
    var title: String = ""
    func body(content: Content) -> some View {
        return content.toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .padding()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    print("Button Tappd")
                } label: {
                    Image(systemName: "plus")
                        .aspectRatio(nil, contentMode: .fit)
                    Text("자산추가")
                        .font(.system(size: 15))
                }
                .tint(Color.black)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = UIColor(white: 1, alpha: 0.5)
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

extension View {
    func navigationWithButtonStyle(_ title: String) -> some View {
        return modifier(NavigationBarWithButton(title: title))
    }
}

struct NavigationBarWithButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Color.gray
                .edgesIgnoringSafeArea(.all)
                .navigationWithButtonStyle("내 자산")
        }
        
    }
}
