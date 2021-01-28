//
//  Fetcher.swift
//  VkNews
//
//  Created by Pyretttt on 29.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation

final class NetworkFetcher: DataFetcher{
    
    //MARK: - Properties
    
    private let taskBuilder: DataTaskBuilder
    private let parser: DataParser
    
    //MARK: - Methods
    
    public init(taskBuilder: DataTaskBuilder, parser: DataParser = DataParser()){
        self.taskBuilder = taskBuilder
        self.parser = parser
    }
    
    public func fetchData<T:Decodable>(type: T.Type, postParseAction: ((T)->())?){
        let task = taskBuilder.build { [weak self, parser] (data, resp, err) in
            if let err = err {
                //TODO: Implement alert and logging
            }
            guard let data = data else {
                //TODO: Implement alert and logging
                return
            }
            
            let dataModel: T? = parser.getDataAsModel(data: data)
            print(dataModel)
            //TODO: Remove force unwrap
            DispatchQueue.main.async {
                postParseAction?(dataModel!)
            }
        }
        task.resume()
    }
}
