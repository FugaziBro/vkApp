//
//  NavigationController.swift
//  VkNews
//
//  Created by Pyretttt on 30.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

extension UINavigationItem{
    public func setNavigationBarImage(image: UIImage){
        let imageView = UIImageView(image: image)
        self.titleView = imageView
    }
}
