//
//  TimeProgressView.swift
//  UIStudy
//
//  Created by Min on 2021/07/15.
//

import UIKit

class TimeProgressView: BaseView {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    private var bgLayer = CAShapeLayer()
    private var grayLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    
    private var seconds: Int = 1000
    private var timer: Timer?

    private func initVars() {
        clipsToBounds = true
    }
    
    private func initBackgroundView() {
        baseView.backgroundColor = .clear
    }
    
    private func initLayers() {
        bgLayer.fillColor = UIColor.clear.cgColor
        bgLayer.lineCap = .round
        bgLayer.lineWidth = 12
        bgLayer.strokeColor = UIColor.white.cgColor
        
        grayLayer.fillColor = UIColor.clear.cgColor
        grayLayer.lineCap = .round
        grayLayer.lineWidth = 3
        grayLayer.strokeColor = UIColor.secondarySystemBackground.cgColor
        
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .square
        progressLayer.lineWidth = 3
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.red.cgColor
    }
    
    private func initLabel() {
        timerLabel.font = .systemFont(ofSize: 10, weight: .regular)
        timerLabel.text = "3:00"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initVars()
        initBackgroundView()
        initLayers()
        initLabel()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawProgressView()
    }
    
    private func drawProgressView() {
        let circlePath = UIBezierPath(arcCenter: .init(x: baseView.frame.size.width / 2,
                                                       y: baseView.frame.size.height / 2),
                                      radius: baseView.frame.size.width / 2.5,
                                      startAngle: -.pi / 2,
                                      endAngle: 3 * .pi / 2,
                                      clockwise: true)
        bgLayer.path = circlePath.cgPath
        grayLayer.path = circlePath.cgPath
        progressLayer.path = circlePath.cgPath
        baseView.layer.addSublayer(bgLayer)
        baseView.layer.addSublayer(grayLayer)
        baseView.layer.addSublayer(progressLayer)
        
        progressAnimation()
        
    }
  
    private func progressAnimation() {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = 10
        circularProgressAnimation.fromValue = 0
        circularProgressAnimation.toValue = 1
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}

extension TimeProgressView {
    func startTimer() {
        if let timer = self.timer {
            timer.invalidate()
            self.timer = nil
        }
        
        seconds = 1000
        timerLabel.text = "\(seconds)"
        

        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(doTimer(sender:)), userInfo: nil, repeats: true)
    }
    
    
    private func stopTimer() {
        if let timer = self.timer {
            timer.invalidate()
            self.timer = nil
            
            if self.seconds == 0 {
                print("TimeOver")
            }
            
            self.seconds = 0
            
            self.timerLabel.text = nil
        }
    }
    
    @objc
    private func doTimer(sender: AnyObject?) {
        seconds -= 1
        timerLabel.text = String.init(format: "%d", seconds / 100 + 1)
        
        if self.seconds == 0 {
            self.stopTimer()
        }
    }
}
