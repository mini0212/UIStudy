//
//  JoinViewController.swift
//  UIStudy
//
//  Created by Min on 2021/07/13.
//

import UIKit

class JoinViewController: UIViewController {

    static func instance() -> JoinViewController {
        let vc = JoinViewController(nibName: self.className, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
