//
//  AgreeViewController.swift
//  UIStudy
//
//  Created by Min on 2021/07/15.
//

import UIKit

class AgreeViewController: UIViewController {
    
    static func instance() -> AgreeViewController {
        let vc = AgreeViewController(nibName: self.className, bundle: nil)
        return vc
    }

    @IBOutlet weak var agreeLabel: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    
    var tapOK: (() -> Void)?
    
    private func initLabel() {
        agreeLabel.font = .systemFont(ofSize: 23, weight: .bold)
        agreeLabel.text = "약관을 확인해주세요"
    }
    
    private func initButtons() {
        agreeButton.titleLabel?.textColor = .white
        agreeButton.setTitle("확인", for: .normal)
        agreeButton.setBackgroundImage(UIImage.imageFromColor(.black), for: .normal)
        agreeButton.roundCorner(radius: 25)
        agreeButton.addTarget(self, action: #selector(tapOK(_:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initLabel()
        initButtons()
    }

}

extension AgreeViewController {
    
    @objc
    private func tapOK(_ sender: UIButton) {
        dismiss(animated: true) {
            self.tapOK?()
        }
    }
}
