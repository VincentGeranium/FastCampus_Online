//
//  PageControl.swift
//  FC_MyAsset
//
//  Created by Morgan Kang on 2022/03/02.
//

import SwiftUI
import UIKit

struct PageControl: UIViewRepresentable {
    var numberOfPage: Int
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPage
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(_:)),
            for: .valueChanged
        )
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
}

class Coordinator: NSObject {
    var control: PageControl
    
    init(_ control: PageControl) {
        self.control = control
    }
    
    @objc func updateCurrentPage(_ sender: UIPageControl) {
        control.currentPage = sender.currentPage
    }
}
