//
//  NewsFeedLayerHandler.swift
//  VkNews
//
//  Created by Pyretttt on 25.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

struct SpinnerAnimator {
   
    //MARK: - Propeties
    
    private let initialView: UIView
    private let criticalValueOfCorner: CGFloat = 10000
    
    //MARK: - Methods
    
    public init(view: UIView){
        self.initialView = view
    }
    
    public func insertSpinnerWithAnimationIntoView(){
        let spinner = createCustomSpinner()
        spinner.add(createSpinnerAnimation(), forKey: "spinnerAnimation")
        initialView.layer.addSublayer(spinner)
    }
    
    private func createCustomSpinner()->CALayer{
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = initialView.bounds.width / 20
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        shapeLayer.fillColor = .none
        shapeLayer.strokeStart = 0.0
        shapeLayer.strokeEnd = 0.05
        
        shapeLayer.frame = initialView.bounds
        shapeLayer.path = createMiddleBasedSpinnerPath()
        
        return shapeLayer
    }
    
    private func createMiddleBasedSpinnerPath()->CGPath{
        let path = UIBezierPath(roundedRect: CGRect(x: initialView.bounds.width / 2 - initialView.bounds.width / 4 , y: initialView.bounds.height / 2 - initialView.bounds.width / 4, width: initialView.bounds.width / 2, height: initialView.bounds.width / 2), cornerRadius: criticalValueOfCorner)
        
        return path.cgPath
    }
    
    private func createSpinnerAnimation()->CAAnimation{
        let strokeAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        strokeAnimation.fromValue = 0.3
        strokeAnimation.autoreverses = true
        strokeAnimation.speed = 2
        strokeAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = CGFloat(Double.pi * 2)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [strokeAnimation, rotationAnimation]
        animationGroup.repeatCount = .infinity
        animationGroup.duration = 1
        
        return animationGroup
    }
    
    public func removeLastSublayerFromView(){
        initialView.layer.sublayers?.popLast()
    }
}
