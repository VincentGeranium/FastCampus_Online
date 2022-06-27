//
//  SeguePresentViewController.swift
//  ScreenTransitionExample
//
//  Created by Morgan Kang on 2021/12/17.
//

import UIKit

class SeguePresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
