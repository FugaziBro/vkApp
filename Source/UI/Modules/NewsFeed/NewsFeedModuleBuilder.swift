//
//  NewsFeedModuleBuilder.swift
//  VkNews
//
//  Created by Pyretttt on 24.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation
import Swinject

class NewsFeedModuleBuilder{
    //MARK: - Properties
    
    private let resolver: Resolver
    
    //MARK: - Methods
    
    public init(resolver: Resolver){
        self.resolver = resolver
    }
    
    func build()->UIViewController{
        let store = resolver.resolve(Store.self)!
        let vm = NewsFeedViewModel(fetcherFactory: resolver.resolve(((DataTaskBuilder)->DataFetcher).self)!, taskFactory: resolver.resolve(((HttpConfig)->DataTaskBuilder).self)!)
        let vc = NewsFeedViewController(viewModel: vm)
        
        return vc
    }
}
