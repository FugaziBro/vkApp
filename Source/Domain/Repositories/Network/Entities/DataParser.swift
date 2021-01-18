//
//  NetworkDataParser.swift
//  VkNews
//
//  Created by Pyretttt on 26.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation

public final class DataParser{
    //MARK: - Propeties
    
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    //MARK: - Methods
    
    public func setDecoder(decoder: JSONDecoder){
        self.decoder = decoder
    }
    
    public func getDataAsModel<T:Decodable>(data: Data)->T?{
        var result: T?
        do{
            result = try decoder.decode(T.self, from: data)
        } catch {
            //TODO: - Implement alert logic and logging
            print(error)
        }
        return result
    }
    
}
