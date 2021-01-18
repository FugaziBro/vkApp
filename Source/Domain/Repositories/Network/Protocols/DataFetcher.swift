//
//  DataFetcher.swift
//  VkNews
//
//  Created by Pyretttt on 26.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation

public protocol DataFetcher{
    func fetchData<T:Decodable>(type: T.Type, postParseAction: ((T)->())?)
}
