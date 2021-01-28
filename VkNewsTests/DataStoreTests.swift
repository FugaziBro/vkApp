//
//  DataStoreTests.swift
//  VkNewsTests
//
//  Created by Pyretttt on 27.01.2021.
//  Copyright © 2021 Бакулин Семен Александрович. All rights reserved.
//

import UIKit
import XCTest
import CoreData
@testable import VkNews

class DataStoreTests: XCTestCase {
    
    private var dataStore: CoreDataStack!
    
    override func setUp() {
        dataStore = CoreDataStack()!
    }
    
    func testPostCreation() throws {
        dataStore.mainContext.performAndWait { [unowned self] in
            let group: GroupInfo = NSManagedObject.init(entity: NSEntityDescription.entity(forEntityName: "GroupInfo", in: self.dataStore.mainContext)!, insertInto: self.dataStore.mainContext) as! GroupInfo
            group.sourceId = "111"
            group.groupName = "Rozetta"
            group.image = UIImage(named: "1")?.pngData()
            
            let post: Post = NSManagedObject.init(entity: NSEntityDescription.entity(forEntityName: "Post", in: self.dataStore.mainContext)!, insertInto: self.dataStore.mainContext) as! Post
            post.comments = 1
            post.views = 1
            post.reposts = 1
            post.likes = 1
            
            post.date = Date()
            post.sourceId = "111"
            
            let fetchR: NSFetchRequest<GroupInfo> = GroupInfo.fetchRequest()
            fetchR.predicate = NSPredicate(format: "sourceId = %@", "\(post.sourceId!)")
            let groups = try! self.dataStore.mainContext.fetch(fetchR)
            
            post.groupInfo = groups.first
            
            
//            let attachement = Attachment(context: self.dataStore.mainContext)
//            attachement.image = UIImage(named: "1")?.pngData()
//            post.addToAttachments(attachement)
            
            
            self.dataStore.saveContextIfNeeded(context: dataStore.mainContext)
            
            print(groups.count)
        }
    }
    
    
    func testCheckEntities() {
//        let fetchPost: NSFetchRequest<Post> = Post.fetchRequest()
//        
//        let posts = try! dataStore.mainContext.fetch(fetchPost)
//        let post = posts.first
//        
//        print(post)
        
    }
    
    override func tearDown() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else { fatalError("error getting url")}
        let sqliteUrl = url.appendingPathComponent("vkNews.sqlite")
        try! dataStore.mainContext.persistentStoreCoordinator?.destroyPersistentStore(at: sqliteUrl, ofType: NSSQLiteStoreType, options: nil)
        
        dataStore = nil
    }
}
