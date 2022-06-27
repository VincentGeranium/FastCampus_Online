//
//  CodePushViewController.swift
//  ScreenTransitionExample
//
//  Created by Morgan Kang on 2021/12/17.
//

import UIKit

class CodePushViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
