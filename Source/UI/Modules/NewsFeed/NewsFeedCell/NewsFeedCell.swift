//
//  NewsFeedCell.swift
//  VkNews
//
//  Created by Бакулин Семен Александрович on 23.11.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation
import UIKit

class NewsFeedCell: UITableViewCell{
    //MARK: - Outlets
    
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var reposts: UILabel!
    @IBOutlet weak var views: UILabel!
    
    @IBOutlet weak var extendButton: UIButton!
    
    @IBOutlet weak var photoGallery: UIStackView!
    //MARK: - Properties
    
    private var viewModel: CellViewModel? {
        willSet {
            newValue?.state.addObserveAction(callback: { [unowned self] (state) in
                                                self.performStateAction() }
        )}
    }
    private let linesLimit = 6
    
    //MOCK: images
    
    private var images: [UIImage] = [UIImage](arrayLiteral: UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!)
    
    //MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    //MARK: - Set views hierarchy
    
    private func setupViews(){
        backgroundColor = .clear
        setupWrapperView()
        setupImageView()
        setupPostTextLabel()
        setupButton()
    }
    
    private func setupWrapperView(){
        wrapperView.layer.cornerRadius = 8
        wrapperView.clipsToBounds = true
    }
    
    private func setupImageView(){
        self.groupImage.layer.cornerRadius = 22
        self.groupImage.layer.masksToBounds = true
    }
    
    private func setupPostTextLabel(){
        self.postText.numberOfLines = linesLimit
    }
    
    private func setupButton(){
        extendButton.addTarget(self, action: #selector(setExtendedState), for: .touchUpInside)
    }
    
    @objc private func setExtendedState(){
        viewModel?.setState(state: .Extended)
    }

    //MARK: - Outside injection
    
    public func setViewModel(with viewModel: CellViewModel){
        self.viewModel = viewModel
        viewModel.setState(state: .Loaded)
    }

    //MARK: - State cycle
    
    private func performStateAction(){
        switch viewModel?.state.value{
            case .Initial:
                clearCell()
            case .Loaded:
                loadCell()
                print(viewModel?.feedItem.attachments?[0].photo?.sizes[0].url)
            case .Extended:
                extendPostText()
            default: break
        }
    }
    
    //MARK: - State .Loaded
    
    private func loadCell(){
        clearCell()
        setData()
        setupExtendButton()
    }
    
    private func clearCell(){
        postText.numberOfLines = linesLimit
        hideButton()
        
    }
    
    private func hideButton(){
        extendButton.isHidden = true
    }
    
    private func setData(){
        guard let viewModel = viewModel else { return }
        groupName.text = viewModel.feedItem.groupName ?? "Неизвестно"
        groupImage.image = viewModel.imageFlyweight.getImage(for: viewModel.feedItem.imageSource!)
        date.text = DateConverter.formateUnixDate(rawDate: viewModel.feedItem.date)
        postText.text = viewModel.feedItem.text
        likes.text = String(viewModel.feedItem.likes.count)
        comments.text = String(viewModel.feedItem.comments.count)
        reposts.text = String(viewModel.feedItem.reposts.count)
        views.text = String(viewModel.feedItem.views.count)
    }
    
    private func setupExtendButton(){
        if shouldBeExtend() {
            showButton()
        }
    }
    
    private func shouldBeExtend()->Bool{
        return (postText.getRowsCount() > postText.numberOfLines) && (postText.numberOfLines > 0)
    }
    
    private func showButton(){
        extendButton.isHidden = false
    }
    
    //MARK: - State .Extended
    
    private func extendPostText(){
        let table = superview as? UITableView
        UIView.performWithoutAnimation {
            table?.beginUpdates()
            postText.numberOfLines = 0
            hideButton()
            table?.endUpdates()
        }
    }
}
    
