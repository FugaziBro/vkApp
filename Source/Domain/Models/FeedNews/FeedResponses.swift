//
//  PostModel.swift
//  VkNews
//
//  Created by Бакулин Семен Александрович on 19.11.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

public class Response: Decodable{
    public let response: Items
    
    public func accept(visitor: Visitor){
        visitor.visit(element: self)
    }
}

public class Items: Decodable{
    public let groups: [Group]?
    public let items: [FeedItem]
}

public class Group: Decodable{
    public let id: Int
    public let name: String
    public let photo50: String
}

public class FeedItem: Decodable{
    public let sourceId: Int
    public let postId: Int
    public let text: String?
    public let date: Double
    public let attachments: [PhotoAttachment]?
    public let comments: CountableItem
    public let likes: CountableItem
    public let reposts: CountableItem
    public let views: CountableItem
    
    //MARK: - Mapped
    
    public var groupName: String?
    public var imageSource: String?
}

public class PhotoAttachment: Decodable{
    public let type: String
    public let photo: Photo?
}

public class Photo: Decodable{
    public let sizes: [PhotoSize]
}

public class PhotoSize: Decodable{
    public let height: Int
    public let width: Int
    public let url: String 
}

public class CountableItem: Decodable{
    public let count: Int
}

