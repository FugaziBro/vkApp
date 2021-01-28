//
//  NewsRootView.swift
//  VkNews
//
//  Created by Pyretttt on 25.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

class NewsRootView: UIView{
    
    //MARK: - Propeties
    
    private let viewModel: NewsFeedViewModel
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier: "cell")
        table.backgroundColor = .clear
        table.separatorStyle = .none
        
        table.refreshControl = self.refresh
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    private lazy var refresh: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refetchData), for: .valueChanged)
        refresh.tintColor =  .clear
        return refresh
    }()
    
    private lazy var spinnerAnimator: SpinnerAnimator = {
        SpinnerAnimator(view: self)
    }()
    
    private lazy var gradientInstaller: GradientInstaller = {
        GradientInstaller(view: self)
    }()
    
    private var tableData: [FeedItem] = [] {
        didSet { tableView.reloadData() }
    }
    
    //MARK: - Methods
    
    public init(viewModel: NewsFeedViewModel){
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        setupRootViews()
        setupStateObserver()
        stateConditionalPresent()
    }
    
    //MARK: - State lifecycle
    
    private func setupStateObserver(){
        viewModel.state.addObserveAction { [weak self] (state) in
            self?.stateConditionalPresent()
        }
    }
    
    private func stateConditionalPresent(){
        switch viewModel.state.value {
        case .Loading:
            presentLoadingSpinner()
        case .Loaded:
            reloadFeedTableView()
        case .Reloading:
            print(#function)
        default:
            print(#function)
        }
    }
    
    private func presentLoadingSpinner(){
        spinnerAnimator.insertSpinnerWithAnimationIntoView()
    }
    
    private func reloadFeedTableView(){
        // Do not use again, because it will delete tableView layer, and app will crash, by accessing non existing table
        refresh.endRefreshing()
        spinnerAnimator.removeLastSublayerFromView()
        tableData = viewModel.data.value!.response.items
    }
    
    @objc
    private func refetchData(){
        tableData = []
        viewModel.fetchFeed()
    }
}

extension NewsRootView{
    //MARK: - Setuping rootView hiearchy
    private func setupRootViews(){
        gradientInstaller.installGradientLayer()
        addAllViews()
        setupTableViewConstraints()
    }
    
    private func addAllViews(){
        addSubview(tableView)
    }
    
    private func setupTableViewConstraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
}

extension NewsRootView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsFeedCell else {
            //TODO: - Make error alert with logging
            fatalError("Cell initialization error")
        }
        
        cell.setViewModel(with: viewModel.cellViewModelForIndex(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
