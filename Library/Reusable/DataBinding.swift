//
//  DataBinding.swift
//  VkNews
//
//  Created by Pyretttt on 24.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation

//MARK: - Implements reactive behavior on value types changes
class DataBinding<T>{
    typealias Callback = (T)->()
    //MARK: - Propeties
    public var value: T {
        didSet{
            for action in callbacks{ action(value) }
        }
    }
    private var callbacks: [Callback] = [Callback]()
    
    //MARK: - Methods
    
    public init(value: T){
        self.value = value
    }
    
    public func addObserveAction(callback: @escaping Callback){
        self.callbacks.append(callback)
    }
}
