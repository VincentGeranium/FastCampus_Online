//
//  SeguePushViewController.swift
//  ScreenTransitionExample
//
//  Created by Morgan Kang on 2021/12/17.
//

import UIKit

class SeguePushViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backbutton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
