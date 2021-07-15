//
//  IntroViewController.swift
//  UIStudy
//
//  Created by Min on 2021/07/13.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var chaiButton: UIButton!
    
    private func initButtons() {
        chaiButton.addTarget(self, action: #selector(tapChaiButton(_:)), for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initButtons()
    }

}

extension IntroViewController {
    
    @objc
    private func tapChaiButton(_ sender: UIButton) {
        let vc = JoinViewController.instance()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: false, completion: nil)
    }
    
}
