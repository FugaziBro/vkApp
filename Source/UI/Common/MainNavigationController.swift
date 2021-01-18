//
//  ViewController.swift
//  VkNews
//
//  Created by Pyretttt on 07.01.2021.
//  Copyright © 2021 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    public init(){
        super.init(nibName: nil, bundle: Bundle.main)
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
