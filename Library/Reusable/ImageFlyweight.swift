//
//  ImageFlyweight.swift
//  VkNews
//
//  Created by Pyretttt on 07.01.2021.
//  Copyright © 2021 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

class ImageFlyweight{
    private var images = [String: UIImage]()
    
    public func getImage(for source: String)->UIImage? {
        if images[source] == nil {
            images[source] = UIImage(source: source)
        }
        return images[source]
    }
}
