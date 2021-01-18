//
//  RequestConfigEntities.swift
//  VkNews
//
//  Created by Pyretttt on 30.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation

public struct RequestConfigFactory{
    public static var newsFeedConfig: HttpConfig {
        HttpRequestConfig(endpoint: NetworkConstants.getNewsFeedEndpoint(),
                                           method: .Get,
                                           data: RequestData.WithParams(queryParams: [ "filters": "post",
                                                                                       "v": NetworkConstants.getApiVersion(),
                                                                                       "access_token": AuthService.accesToken! ],
                                                                        body: nil,
                                                                        headers: nil))
    }
}
