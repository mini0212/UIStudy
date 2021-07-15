//
//  JoinViewController.swift
//  UIStudy
//
//  Created by Min on 2021/07/13.
//

import UIKit
import RxSwift
import RxCocoa

enum TextType {
    case phoneNumber // 휴대폰번호
    case registration // 주민등록번호
    case carrier // 통신사
    case name // 이름
    
    var infoTitle: String {
        switch self {
        case .phoneNumber:
            return "휴대폰번호를\n입력해주세요"
        case .registration:
            return "주민번호 앞 7자리를\n입력해주세요"
        case .carrier:
            return "통신사를\n선택해주세요"
        case .name:
            return "이름을\n입력해주세요"
        }
    }
}

class JoinViewController: UIViewController {

    static func instance() -> JoinViewController {
        let vc = JoinViewController(nibName: self.className, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var scrollBaseView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var carrierView: UIView!
    @IBOutlet weak var carrierLabel: UILabel!
    @IBOutlet weak var carrierNameLabel: UILabel!
    @IBOutlet weak var registrationView: UIView!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var keyboardBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var borderView: UIView!
    
    var disposeBag = DisposeBag()
    
    private func initBackgroundColor() {
        view.backgroundColor = .secondarySystemBackground
        scrollBaseView.backgroundColor = .clear
        borderView.backgroundColor = .clear
        borderView.isUserInteractionEnabled = false
    }
    
    private func initViews() {
        nameView.roundCorner(radius: 20)
        carrierView.roundCorner(radius: 20)
        registrationView.roundCorner(radius: 20)
        phoneView.roundCorner(radius: 20)
        
        nameView.isHidden = true
        carrierView.isHidden = true
        registrationView.isHidden = true

        borderView.roundCorner(radius: 20)
        borderView.borderColor(width: 3, color: .black)
    }
    
    private func initLabels() {
        infoLabel.font = .systemFont(ofSize: 24, weight: .bold)
        infoLabel.textColor = .black
        infoLabel.text = TextType.phoneNumber.infoTitle
        
        nameLabel.font = .systemFont(ofSize: 12, weight: .regular)
        nameLabel.textColor = .gray
        nameLabel.text = "이름"
        
        registerLabel.font = .systemFont(ofSize: 12, weight: .regular)
        registerLabel.textColor = .gray
        registerLabel.text = "주민등록번호"
        
        carrierLabel.font = .systemFont(ofSize: 12, weight: .regular)
        carrierLabel.textColor = .gray
        carrierLabel.text = "통신사"
        
        carrierNameLabel.font = .systemFont(ofSize: 23, weight: .bold)
        carrierNameLabel.textColor = .black
        carrierNameLabel.text = nil
        
        phoneLabel.font = .systemFont(ofSize: 12, weight: .regular)
        phoneLabel.textColor = .gray
        phoneLabel.text = "휴대폰번호"
    }
    
    private func initTextFields() {
        nameTextField.font = .systemFont(ofSize: 23, weight: .semibold)
        birthTextField.font = .systemFont(ofSize: 23, weight: .semibold)
        genderTextField.font = .systemFont(ofSize: 23, weight: .semibold)
        phoneTextField.font = .systemFont(ofSize: 23, weight: .semibold)

        nameTextField.keyboardType = .default
        birthTextField.keyboardType = .numberPad
        genderTextField.keyboardType = .numberPad
        phoneTextField.keyboardType = .phonePad
    }
    
    private func initKeyboardAccessoryView() {
        okButton.setTitle("확인", for: .normal)
        okButton.setTitleColor(.white, for: .normal)
        okButton.setBackgroundImage(UIImage.imageFromColor(.lightGray), for: .disabled)
        okButton.setBackgroundImage(UIImage.imageFromColor(.black), for: .normal)
        okButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        okButton.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initBackgroundColor()
        initViews()
        initLabels()
        initTextFields()
        initKeyboardAccessoryView()
        initObservers()
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        phoneTextField.becomeFirstResponder()
    }
    
    deinit {
        deInitObservers()
    }

}

extension JoinViewController {
    
    private func bind() {
        phoneTextField.rx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .compactMap { $0.count == 11 }
            .subscribe(onNext: { [weak self] isDone in
                if isDone {
                    self?.showRegistView()
                }
            }).disposed(by: disposeBag)
        
        birthTextField.rx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .compactMap { $0.count == 6 }
            .bind(onNext: { [weak self] isEnable in
                if isEnable {
                    self?.genderTextField.becomeFirstResponder()
                }
            }).disposed(by: disposeBag)
        
        genderTextField.rx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .compactMap { $0.count == 1 }
            .bind(onNext: { [weak self] isEnable in
                if isEnable {
                    self?.showCarrierView()
                }
            }).disposed(by: disposeBag)
        
        nameTextField.rx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .compactMap { $0.count > 0 }
            .bind(to: okButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func showRegistView() {
        nameTextField.endEditing(true)
        birthTextField.becomeFirstResponder()
        UIView.animate(withDuration: 0.25) {
            self.infoLabel.text = TextType.registration.infoTitle
            self.registrationView.isHidden = false
        }
    }
    
    private func showCarrierView() {
        genderTextField.endEditing(true)
        
        UIView.animate(withDuration: 0.25) {
            self.infoLabel.text = TextType.carrier.infoTitle
            self.carrierView.isHidden = false
        }
        
        DispatchQueue.main.async {
            let vc = CarrierViewController.instance()
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self
            self.present(vc, animated: false, completion: nil)
        }
    }
    
}

extension JoinViewController: CarrierViewControllerDelegate {
    func selectedCarrier(text: String) {
        carrierNameLabel.text = text
        showNameView()
    }
    
    private func showNameView() {
        nameTextField.becomeFirstResponder()
        okButton.isHidden = false
        UIView.animate(withDuration: 0.25) {
            self.infoLabel.text = TextType.name.infoTitle
            self.nameView.isHidden = false
        }
    }
}


extension JoinViewController {
    private func initObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(sender:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(sender:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func deInitObservers() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc
    private func keyboardWillShow(sender: NSNotification) {
        let userInfo = sender.userInfo
        let value = userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
        let keyboardRect = (value as! NSValue).cgRectValue
        
        keyboardBottomConstraint.constant = keyboardRect.size.height - (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0)
        view.layoutIfNeeded()
    }
    
    @objc
    private func keyboardWillHide(sender: NSNotification) {
        keyboardBottomConstraint.constant = 0.0
        view.layoutIfNeeded()
    }

}
