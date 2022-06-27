//
//  MyView.swift
//  FC_SwiftUIPractice
//
//  Created by Morgan Kang on 2022/02/25.
//

import SwiftUI

struct MyView: View {
    let helloFont: Font
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(helloFont)
            Text("만나서 반가워요.")
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView(helloFont: .title)
    }
}
