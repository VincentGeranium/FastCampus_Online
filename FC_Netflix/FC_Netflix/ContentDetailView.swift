//
//  ContentDetailView.swift
//  FC_Netflix
//
//  Created by Morgan Kang on 2022/02/25.
//

import SwiftUI

struct ContentDetailView: View {
    @State var item: Item?
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            ZStack(alignment: .bottom) {
                if let item = item {
                    Image(uiImage: item.image)
                        .resizable()
                        .aspectRatio(nil, contentMode: .fit)
                        .frame(width: 200,
                               height: nil,
                               alignment: .center)
                    Text(item.description)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(Color.primary)
                        .background(Color.primary
                                        .colorInvert()
                                        .opacity(0.75)
                        )
                } else {
                    // item이 없는 경우 흰색 바탕만 보이도록.
                    Color.white
                }
            }
        }
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyItem = Item(description: "흥미진진, 애니메이션, 판타지, 액션 애니매이션, 멀티 캐스팅", imageName: "poster0")
        ContentDetailView(item: dummyItem)
    }
}
