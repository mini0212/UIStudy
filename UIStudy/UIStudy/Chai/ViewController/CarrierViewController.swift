//
//  CarrierViewController.swift
//  UIStudy
//
//  Created by Min on 2021/07/15.
//

import UIKit

protocol CarrierViewControllerDelegate: AnyObject {
    func selectedCarrier(text: String)
}

class CarrierViewController: UIViewController {

    static func instance() -> CarrierViewController {
        let vc = CarrierViewController(nibName: self.className, bundle: nil)
        return vc
    }
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var popupViewBottomConstraint: NSLayoutConstraint!
    
    weak var delegate: CarrierViewControllerDelegate?
    
    private let carrierList: [String] = [
    "SKT", "KT", "LG U+", "SKT 알뜰폰", "KT 알뜰폰", "LG U+ 알뜰폰"
    ]
    
    private func initBackgroundView() {
        view.backgroundColor = .black.withAlphaComponent(0.4)
        view.alpha = 0
        baseView.backgroundColor = .clear
        topView.backgroundColor = .black
        bottomView.backgroundColor = .black
        tableView.backgroundColor = .black
        
        topView.roundCorner(radius: 20)
        
        popupViewBottomConstraint.constant = -UIScreen.main.bounds.size.height
    }
    
    private func initTableView() {
        tableView.register(UINib(nibName: CarrierCell.className, bundle: nil), forCellReuseIdentifier: CarrierCell.className)
        
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func initLabel() {
        nameLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        nameLabel.textColor = .white
        nameLabel.text = "통신사선택"
    }
    
    private func initButton() {
        closeButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        closeButton.setTitle("닫기", for: .normal)
        closeButton.setTitleColor(.gray, for: .normal)
        closeButton.addTarget(self, action: #selector(tapDismiss(_:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initBackgroundView()
        initButton()
        initLabel()
        initTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAnimation()
    }

}

extension CarrierViewController {

    @objc
    private func tapDismiss(_ sender: UIButton) {
        dismissVC()
    }
    
    private func dismissVC() {
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 0.0
            
            self.popupViewBottomConstraint.constant = -UIScreen.main.bounds.size.height
            self.view.layoutIfNeeded()
        } completion: { (_ ) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
}

extension CarrierViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carrierList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarrierCell.className, for: indexPath) as? CarrierCell else { return .init() }
        let item = carrierList[indexPath.row]
        cell.bind(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension CarrierViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = carrierList[indexPath.row]
        delegate?.selectedCarrier(text: item)
        dismissVC()
    }
}

extension CarrierViewController {
    private func showAnimation() {
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1.0
        }
        
        UIView.animate(withDuration: 0.8,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.popupViewBottomConstraint.constant = 0.0
                        self.view.layoutIfNeeded()
        }) { (_ ) in
            
        }
    }
}
