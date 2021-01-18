//
//  File.swift
//  VkNews
//
//  Created by Pyretttt on 29.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation

struct HttpRequestConfig: HttpConfig{
    let endpoint: String
    
    let method: HttpMethod
    
    let data: RequestData
    
    public init(endpoint: String, method: HttpMethod, data: RequestData){
        self.endpoint = endpoint
        self.method = method
        self.data = data
    }
}
