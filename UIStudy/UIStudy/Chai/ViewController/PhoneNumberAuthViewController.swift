//
//  PhoneNumberAuthViewController.swift
//  UIStudy
//
//  Created by Min on 2021/07/15.
//

import UIKit

class PhoneNumberAuthViewController: UIViewController {
    
    static func instance() -> PhoneNumberAuthViewController {
        let vc = PhoneNumberAuthViewController(nibName: self.className, bundle: nil)
        return vc
    }
  
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var timeProgressView: TimeProgressView!
    @IBOutlet weak var borderView: UIView!
    
    
    private func initBackgroundView() {
        borderView.backgroundColor = .clear
    }
    
    private func initLabels() {
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.text = "인증번호를\n입력해주세요"
        
        numberLabel.font = .systemFont(ofSize: 12, weight: .regular)
        numberLabel.textColor = .gray
        numberLabel.text = "인증번호"
    }
    
    private func initTextField() {
        numberTextField.font = .systemFont(ofSize: 23, weight: .semibold)
        numberTextField.keyboardType = .numberPad
        numberTextField.becomeFirstResponder()
    }
    
    private func initView() {
        borderView.roundCorner(radius: 20)
        borderView.borderColor(width: 3, color: .black)
        borderView.isUserInteractionEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initBackgroundView()
        initLabels()
        initTextField()
        initView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        timeProgressView.startTimer()
    }

}
