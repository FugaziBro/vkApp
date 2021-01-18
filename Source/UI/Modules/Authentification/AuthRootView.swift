//
//  LoginButton.swift
//  VkNews
//
//  Created by Бакулин Семен Александрович on 21.12.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

class AuthRootView: UIView {
    //MARK: - Properties
    
    private unowned let viewModel: AuthViewModel
    public lazy var loginButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.layer.cornerRadius = 15
        button.addTarget(viewModel, action: #selector(viewModel.loginWithVkApi), for: .touchUpInside)
        button.addTarget(self, action: #selector(animateLoginButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    
    public init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("AuthRootView can't be implemented")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        setupRootViews()
    }
    
    
    //MARK: - Methods
    
    @objc
    private func animateLoginButton(){
        let springAnimation = CASpringAnimation(keyPath: "transform.scale.x")
        springAnimation.damping = 7
        springAnimation.stiffness = 150
        springAnimation.fromValue = 1.05
        springAnimation.duration = springAnimation.settlingDuration
        
        loginButton.layer.add(springAnimation, forKey: "springAnimationLoginButton")
    }
}

extension AuthRootView{
    
    private func setupRootViews(){
        addAllViews()
        setupSelfView()
        setupBtnConstraints()
    }
    
    private func addAllViews(){
        addSubview(loginButton)
    }
    
    private func setupSelfView(){
        backgroundColor = .white
    }
    
    private func setupBtnConstraints(){
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -80),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
}
