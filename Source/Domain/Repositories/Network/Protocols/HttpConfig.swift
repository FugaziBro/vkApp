//
//  RequestConfig.swift
//  VkNews
//
//  Created by Pyretttt on 29.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation

public protocol HttpConfig {
    var scheme: String { get }
    var baseUrl: String { get }
    var endpoint: String { get }
    var method: HttpMethod { get }
    var data: RequestData { get }
}

extension HttpConfig{
    var scheme: String { NetworkConstants.getScheme() }
    var baseUrl: String { NetworkConstants.getHost() }
}
