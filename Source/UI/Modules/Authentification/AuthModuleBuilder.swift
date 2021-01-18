//
//  AuthModuleBuilder.swift
//  VkNews
//
//  Created by Pyretttt on 22.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit
import Swinject

final class AuthModuleBuilder{
    //MARK: - Properties
    
    private let resolver: Resolver
    
    //MARK: - Methods
    
    init(resolver: Resolver){
        self.resolver = resolver
    }
    
    public func build(authDelegate: AuthServiceDelegate)->UIViewController{
        let authService: AuthService = resolver.resolve(AuthService.self, argument: authDelegate)!
        let viewModel = AuthViewModel(authService: authService)
        let vc =  AuthViewController(viewModel: viewModel)
        
        return vc
    }
    
}
