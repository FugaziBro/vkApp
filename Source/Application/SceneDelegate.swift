//
//  SceneDelegate.swift
//  VkNews
//
//  Created by Бакулин Семен Александрович on 15.11.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit
import Swinject
import VK_ios_sdk

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    public let assembler = Assembler([MainAssembly(), NewsFeedAssembly()])
    public let nav: UINavigationController = MainNavigationController()
    public let coordinator: Coordinatable
    
    public override init(){
        coordinator = assembler.resolver.resolve(Coordinatable.self, name: "Main", argument: self.nav)!
        super.init()
    }
    
    public static func shared()->SceneDelegate{
        let scene = UIApplication.shared.connectedScenes.first
        guard let sd: SceneDelegate = scene?.delegate as? SceneDelegate else { fatalError("Can not get scene Delegate") }
        return sd
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = nav
        
        coordinator.start()
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        // Реализация метода не понятна - проверяет схему из info.plist на возможность использования приложения по токену?
        if let url = URLContexts.first?.url {
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        }
    }
}

