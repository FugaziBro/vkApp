//
//  GradientLayer.swift
//  VkNews
//
//  Created by Pyretttt on 07.01.2021.
//  Copyright © 2021 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

struct GradientInstaller {
    //MARK: - Propeties
    
    private let initialView: UIView
    
    //MARK: - Methods
    
    public init(view: UIView){
        self.initialView = view
    }
    
    public func installGradientLayer(){
        let layer = CAGradientLayer()
        layer.endPoint = CGPoint(x: 0.0, y: 0.0)
        layer.startPoint = CGPoint(x: 0.5, y: 1.0)
        layer.colors = [#colorLiteral(red: 1, green: 0.842753368, blue: 0.7279900476, alpha: 1).cgColor, #colorLiteral(red: 0.4767173689, green: 0.8198255123, blue: 0.927465174, alpha: 1).cgColor]
        layer.frame = initialView.bounds
        
        initialView.layer.addSublayer(layer)
    }
}
