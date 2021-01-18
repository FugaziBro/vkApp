//
//  RequestData.swift
//  VkNews
//
//  Created by Pyretttt on 29.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation

public enum RequestData{
    case Empty
    case WithParams(queryParams: [String: String]?, body: [String: Any]?, headers: [String: String]?)
    
    public func getData()->(queryParams:[String: String]?, body: [String: Any]?, headers: [String: String]?){
        switch self{
            case .Empty:
            return(nil, nil, nil)
        case .WithParams(let queryParams, let body, let headers):
            return (queryParams, body, headers)
        }
    }
}
