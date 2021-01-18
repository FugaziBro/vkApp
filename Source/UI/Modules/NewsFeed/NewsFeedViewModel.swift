//
//  NewsFeedViewModel.swift
//  VkNews
//
//  Created by Pyretttt on 24.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation

class NewsFeedViewModel{
    //MARK: - Properties

    public let state: DataBinding<NewsFeedState>
    public var data = DataBinding<Response?>(value: nil)
    private let fetcherFactory: (DataTaskBuilder)->DataFetcher
    private let taskFactory: (HttpConfig)->DataTaskBuilder
    public let imageFlyweight: ImageFlyweight
    
    //MARK: - Methods
    
    public init(fetcherFactory: @escaping(DataTaskBuilder)->DataFetcher,
                taskFactory: @escaping (HttpConfig)->DataTaskBuilder, imageFlyweight: ImageFlyweight = ImageFlyweight()){
        self.state = DataBinding<NewsFeedState>(value: .Loading)
        self.fetcherFactory = fetcherFactory
        self.taskFactory = taskFactory
        self.imageFlyweight = imageFlyweight
        self.setCacheObserver()
    }
    
    private func setCacheObserver(){
        data.addObserveAction { [weak self] (_) in
            self?.state.value = .Loaded
        }
    }
    
    public func fetchFeed(){
        self.state.value = .Loading
        let dataTask = taskFactory(RequestConfigFactory.newsFeedConfig)
        let fetcher = fetcherFactory(dataTask)
        fetcher.fetchData(type: Response.self, postParseAction: { [weak self] in
                let visitor = NewsFeedMapperVisitor()
                $0.accept(visitor: visitor)
                self?.data.value = $0
        })
    }
    
    public func cellViewModelForIndex(indexPath: IndexPath)->CellViewModel{
        let indexRow = indexPath.row
        guard let data = data.value else {
            //TODO: - implement alert error and logging
            fatalError("Could not get data, but it's necessary") }
        
        return CellViewModel(feedItem: data.response.items[indexRow], imageFlyweight: imageFlyweight)
    }
}
