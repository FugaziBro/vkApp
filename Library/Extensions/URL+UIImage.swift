//
//  URL+UIImage.swift
//  VkNews
//
//  Created by Pyretttt on 07.01.2021.
//  Copyright © 2021 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

extension UIImage{
    
    public convenience init?(source: String){
        let url = URL(string: source)
        
        guard let data = try? Data(contentsOf: url!) else {
            fatalError()
        }
        
        self.init(data: data)
    }
}
