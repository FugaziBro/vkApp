//
//  NewsFeedCoordinator.swift
//  VkNews
//
//  Created by Pyretttt on 24.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit
import Swinject

final class NewsFeedCoordinator: Coordinatable {
    //MARK: - Properties
    var childCoordinators: [Coordinatable] = []
    private let navigationController: UINavigationController
    private let resolver: Resolver
    
    //MARK: - Methods
    
    public init(nav: UINavigationController, resolver: Resolver){
        self.navigationController = nav
        self.resolver = resolver
    }
    
    func start() {
        showNewsFeedModule()
    }
    
    private func showNewsFeedModule(){
        navigationController.pushViewController(createNewsFeedVC(), animated: true)
    }
    
    private func createNewsFeedVC()->UIViewController{
        let builder = resolver.resolve(NewsFeedModuleBuilder.self)!
        return builder.build()
    }
    
    func end() {
        navigationController.popViewController(animated: true)
    }
}
