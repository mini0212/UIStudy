//
//  BaseView.swift
//  UIStudy
//
//  Created by Min on 2021/07/13.
//

import UIKit

class BaseView: UIView {

    // MARK: - Vars
    
    var containerView: UIView!

    // MARK: - Life Cycle
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initView()
    }
    
    func initView() {
        containerView = Bundle.main.loadNibNamed(self.className, owner: self, options: nil)?.first as? UIView
        containerView.frame = self.bounds
        containerView.backgroundColor = .clear
        addSubview(containerView)
    }

}
