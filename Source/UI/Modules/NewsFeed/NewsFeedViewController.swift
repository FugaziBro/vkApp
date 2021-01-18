//
//  FeedViewController.swift
//  VkNews
//
//  Created by Бакулин Семен Александрович on 18.11.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {
    //MARK: - Properties
    
    private let viewModel: NewsFeedViewModel
    
    //MARK: - Methods
    
    public init(viewModel: NewsFeedViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        hideBackButtonAtNavItem()
        setLogoImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = NewsRootView(viewModel: self.viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchFeed()
    }
    
    private func hideBackButtonAtNavItem(){
        self.navigationItem.hidesBackButton = true
    }
    
    private func setLogoImage(){
        let image = UIImage(named: "logo")!
        navigationItem.setNavigationBarImage(image: image)
    }
}
