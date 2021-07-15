//
//  CarrierCell.swift
//  UIStudy
//
//  Created by Min on 2021/07/15.
//

import UIKit

class CarrierCell: UITableViewCell {

    @IBOutlet weak var carrierLabel: UILabel!
    
    private func initBackgroundColor() {
        backgroundColor = .black
    }
    
    private func initLabel() {
        carrierLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        carrierLabel.textColor = .gray
        carrierLabel.text = nil
    }
    
    private func initView() {
        selectionStyle = .none
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initBackgroundColor()
        initView()
        initLabel()
    }
    
}

extension CarrierCell {
    
    func bind(_ text: String) {
        carrierLabel.text = text
    }
}
