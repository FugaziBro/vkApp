//
//  CellViewModel.swift
//  VkNews
//
//  Created by Pyretttt on 27.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation

class CellViewModel{
    
    //MARK: - Propeties
    
    public let state = DataBinding<CellState>(value: .Initial)
    public let feedItem: FeedItem
    public let imageFlyweight: ImageFlyweight

    //MARK: - Methods
    
    public init(feedItem: FeedItem, imageFlyweight: ImageFlyweight){
        self.feedItem = feedItem
        self.imageFlyweight = imageFlyweight
    }
    
    public func setState(state: CellState){
        self.state.value = state
    }
}
