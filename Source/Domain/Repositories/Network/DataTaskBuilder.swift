//
//  DataTaskBuilder.swift
//  VkNews
//
//  Created by Pyretttt on 29.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation

final public class DataTaskBuilder{
    
    //MARK: - Propeties
    
    private let requestConfig: HttpConfig
    lazy var requestData: (queryParams:[String: String]?, body: [String: Any]?, headers: [String: String]?) = requestConfig.data.getData()
    private let TIMEOUT: TimeInterval = 7
    
    //MARK: - Methods
    
    init(requestConfig: HttpConfig){
        self.requestConfig = requestConfig
    }
    
    public func build(completionHandler: @escaping (Data?, URLResponse?, Error?)->())->URLSessionDataTask{
        return URLSession.shared.dataTask(with: createUrlRequest(), completionHandler: completionHandler)
    }
    
    private func createUrlRequest()->URLRequest{
        var request = URLRequest(url: self.createUrl(), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: TIMEOUT)
        addAdditionalHeader(to: &request)
        addBody(to: &request)
        return request
    }
    
    private func createUrl()->URL{
        var components = URLComponents()
        components.scheme = requestConfig.scheme
        components.host = requestConfig.baseUrl
        components.path = requestConfig.endpoint
        components.queryItems = requestData.queryParams?.map({ (key, value) in
            URLQueryItem(name: key, value: value)
        })
        print(components.url!)
        return components.url!
    }
    
    private func addAdditionalHeader(to: inout URLRequest){
        guard let headers = self.requestData.headers else { return }
        headers.forEach { (key,value) in
            to.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    private func addBody(to: inout URLRequest){
        guard let body = self.requestData.body else { return }
        do{
            let jsonBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            to.httpBody = jsonBody
        } catch {
            //TODO: - Implement alert and logging
            debugPrint(error)
        }
    }
}
