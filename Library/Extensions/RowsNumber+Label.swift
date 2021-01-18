//
//  RowsNumber+Label.swift
//  VkNews
//
//  Created by Pyretttt on 08.01.2021.
//  Copyright © 2021 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

extension UILabel{
    public func getRowsCount()->Int{
        let maxSize = CGSize(width: frame.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).height
        let lineHeight = font.lineHeight
        return Int((textHeight / lineHeight).rounded(.up))
    }
}
