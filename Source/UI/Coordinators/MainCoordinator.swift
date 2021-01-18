//
//  MainCoordinator.swift
//  VkNews
//
//  Created by Бакулин Семен Александрович on 20.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit
import Swinject

final class MainCoordinator: Coordinatable{
    
    //MARK: - Properties
    var childCoordinators: [Coordinatable] = []
    private let navigationController: UINavigationController
    private let resolver: Resolver
    
    //MARK: -Methods
    init(nav: UINavigationController, resolver: Resolver){
        self.navigationController = nav
        self.resolver = resolver
    }
    
    func start() {
        showAuthVC()
    }
    
    private func showAuthVC(){
        self.navigationController.pushViewController(createAuthVC(), animated: false)
    }
    
    private func createAuthVC()->UIViewController{
        let builder = resolver.resolve(AuthModuleBuilder.self)!
        let vc = builder.build(authDelegate: self)
        return vc
    }
    
    func end() {
        fatalError("Main app coordinator can't be removed")
    }
}

extension MainCoordinator: AuthServiceDelegate {
    
    func authServiceShouldShow(vc: UIViewController) {
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    func authServiceSignIn(){
        let newsCoordinator = resolver.resolve(Coordinatable.self, name: "News", argument: navigationController)!
        self.childCoordinators.append(newsCoordinator)
        newsCoordinator.start()
    }
    
    func authServiceSignDidFail() {
        print(#function)
    }
}
