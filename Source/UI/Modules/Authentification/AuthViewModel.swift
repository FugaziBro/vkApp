//
//  AuthViewModel.swift
//  VkNews
//
//  Created by Pyretttt on 22.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation

final class AuthViewModel {
    //MARK: - Properties
    
    public let authService: AuthService
    
    //MARK: - Methods
    
    public init(authService: AuthService){
        self.authService = authService
    }
    
    @objc
    public func loginWithVkApi(){
        authService.wakeUpSession()
    }
    
}
