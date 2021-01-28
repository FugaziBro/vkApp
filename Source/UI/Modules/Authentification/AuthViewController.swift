//
//  ViewController.swift
//  VkNews
//
//  Created by Бакулин Семен Александрович on 15.11.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    //MARK: - Properties
    
    private let viewModel: AuthViewModel
    
    //MARK: - Lifecycle
    
    public init(viewModel: AuthViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinited")
    }
    
    override func loadView(){
        view = AuthRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleHideOfNavigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        toggleHideOfNavigation()
    }
    
    //MARK: - Methods
    
    private func toggleHideOfNavigation(){
        self.navigationController?.isNavigationBarHidden.toggle()
    }
}

