//
//  DateFormatter.swift
//  VkNews
//
//  Created by Pyretttt on 07.01.2021.
//  Copyright © 2021 Бакулин Семен Александрович. All rights reserved.
//

import Foundation

struct DateConverter{
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm, MMMM d"
        return formatter
    }()
    
    public static func formateUnixDate(rawDate: Double)->String{
        return self.formatter.string(from: Date(timeIntervalSince1970: rawDate))
    }
}
