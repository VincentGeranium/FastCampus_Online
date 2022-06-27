//
//  ContentView.swift
//  FC_Netflix
//
//  Created by Morgan Kang on 2022/02/25.
//

import SwiftUI

struct ContentView: View {
    let titles = ["Netflix Sample App"]
    
    var body: some View {
        NavigationView {
            List(titles, id: \.self) {
                let netflixVC = HomeViewControllerRepresentable().navigationBarHidden(true)
                    .edgesIgnoringSafeArea(.all)
                NavigationLink($0, destination: netflixVC)
            }
            .navigationTitle("SwiftUI to UIKit.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
