//
//  MapperVisitor.swift
//  VkNews
//
//  Created by Pyretttt on 07.01.2021.
//  Copyright © 2021 Бакулин Семен Александрович. All rights reserved.
//

import Foundation

class NewsFeedMapperVisitor: Visitor{
    
    //MARK: - Properties
    
    private var groupsDict = [Int: [String]]()
    
    //MARK: - Methods
    
    public func visit(element: Any) {
        guard let element = element as? Response else {
            //TODO: - Make logging and error handler
            print("Wrong mapper visitor")
            return
        }
        iterateGroups(element: element)
        mapPostToGroups(element: element)
    }
    
    private func iterateGroups(element: Response){
        let groups = element.response.groups
        for group in groups!{
            if groupsDict[group.id] == nil {
                groupsDict[group.id] = [group.name, group.photo50]
            }
            continue
        }
    }
    
    private func mapPostToGroups(element: Response){
        let posts = element.response.items
        for post in posts{
            fillGroupName(post: post)
            fillGroupImage(post: post)
        }
    }
    
    private func fillGroupName(post: FeedItem){
        post.groupName = groupsDict[-post.sourceId]![0]
    }
    
    private func fillGroupImage(post: FeedItem){
        post.imageSource = groupsDict[-post.sourceId]![1]
    }
}
