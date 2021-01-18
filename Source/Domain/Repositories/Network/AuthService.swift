//
//  AuthService.swift
//  VkNews
//
//  Created by Бакулин Семен Александрович on 17.11.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: class {
    func authServiceShouldShow(vc: UIViewController)
    func authServiceSignIn()
    func authServiceSignDidFail()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate{
    //MARK: - Properties
    
    private let vkSdk: VKSdk
    
    public unowned let delegate: AuthServiceDelegate
    
    //MARK: - Methods
    
    public init(delegate: AuthServiceDelegate){
        self.delegate = delegate
        self.vkSdk = VKSdk.initialize(withAppId: NetworkConstants.getAppId())
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    public func wakeUpSession(){
        let scope = ["wall","friends"]
        
        VKSdk.wakeUpSession(scope) { [delegate] (state, err) in
            switch state{
            case .initialized:
                VKSdk.authorize(scope)
            case .authorized:
                delegate.authServiceSignIn()
            default:
                delegate.authServiceSignDidFail()
            }
        }
    }
    
    public static var accesToken: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    //MARK: - VK Delegate and UIDelegate
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil{
            delegate.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        delegate.authServiceSignDidFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate.authServiceShouldShow(vc: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
    
}
