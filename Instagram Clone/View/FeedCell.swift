//
//  FeedCell.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/02/17.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class FeedCell: UICollectionViewCell
{
    
    static let FeedCellId = "FeedCellID"
    
    var delegate:FeedCellDelegate?
    
    
    var selectedPost: Post?
    {
        didSet
        {
              configureFeedCell()
             configureLikebutton()
        }
    }
    
    lazy var profilepicture: CustomImageView =
        {
            let propic = CustomImageView()
            propic.translatesAutoresizingMaskIntoConstraints = false
            propic.clipsToBounds =  true
            propic.layer.masksToBounds = true
            propic.contentMode = .scaleAspectFill
            propic.backgroundColor = .lightGray
            NSLayoutConstraint.activate([propic.heightAnchor.constraint(equalToConstant: 50),
                                         propic.widthAnchor.constraint(equalToConstant: 50)
            ])
            
            propic.layer.cornerRadius = 50 / 2
            
            
            return propic
    }()
    
    lazy var usernameButton: UIButton =
        {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.setTitleColor(.darkGray, for: [])
            
            button.addTarget(self, action: #selector(Handleusername), for: .primaryActionTriggered)
            return button
    }()
    
    lazy var FeedCellOption: UIButton =
        {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("•••", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button.setTitleColor(.darkGray, for: [])
            
            button.addTarget(self, action: #selector(HandleOptionPressed), for: .primaryActionTriggered)
            return button
    }()
    
    lazy var postImage: CustomImageView =
        {
            let propic = CustomImageView()
            propic.translatesAutoresizingMaskIntoConstraints = false
            propic.clipsToBounds =  true
            propic.layer.masksToBounds = true
            propic.contentMode = .scaleAspectFill
            propic.backgroundColor = .lightGray
            propic.heightAnchor.constraint(equalToConstant: 420).isActive = true
            return propic
    }()
    
    
    
    lazy var LikeButton: UIButton =
        {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
           
            button.addTarget(self, action: #selector(Handlelike), for: .primaryActionTriggered)
            return button
    }()
    
    
    lazy var CommentButton: UIButton =
        {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "comment")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
            button.addTarget(self, action: #selector(HandleComment), for: .primaryActionTriggered)
            return button
    }()
    
    
    lazy var MessageButton: UIButton =
        { let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "send2")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
            button.addTarget(self, action: #selector(HandleMessgae), for: .primaryActionTriggered)
            return button
    }()
    
    
    
    lazy var savePostButton: UIButton =
        { let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "ribbon")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
            button.addTarget(self, action: #selector(HandleSavePost), for: .primaryActionTriggered)
            return button
    }()
    
    
    var likesLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    var captionMessage: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    var timeLable: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "3 DAYS AGO"
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func Handleusername()
    {
        delegate?.usernameButtonTapped(cell: self, buttonPressed: self.usernameButton)
    }
    
    @objc func HandleOptionPressed()
    {
        delegate?.feedCellOptionButtonTapped(cell: self, buttonPressed: self.FeedCellOption)
    }
    
    
    @objc func Handlelike()
    {
        delegate?.FeedLikeButtonTapped(cell: self, buttonPressed: self.LikeButton)
    }
    @objc func HandleComment()
    {
        delegate?.FeedCommentbuttonTapped(cell: self, buttonPressed: self.CommentButton)
    }
    @objc func HandleMessgae()
    {
        delegate?.FeedMessageButtonTapped(cell: self, buttonPressed: self.MessageButton)
    }
    @objc func HandleSavePost()
    {
        delegate?.BookmarkButtonTapped(cell: self, buttonPressed: self.savePostButton)
    }
    
    
}
extension FeedCell
{
    private func style()
    {
        self.addSubview(profilepicture)
        self.addSubview(usernameButton)
        self.addSubview(FeedCellOption)
        self.addSubview(postImage)
        
    }
    
    
    private func layout()
    {
        NSLayoutConstraint.activate([profilepicture.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 1),
                                     profilepicture.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([usernameButton.centerYAnchor.constraint(equalTo: profilepicture.centerYAnchor),
                                     usernameButton.leadingAnchor.constraint(equalToSystemSpacingAfter: profilepicture.trailingAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([FeedCellOption.centerYAnchor.constraint(equalTo: usernameButton.centerYAnchor),
                                     self.trailingAnchor.constraint(equalToSystemSpacingAfter: FeedCellOption.trailingAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([postImage.topAnchor.constraint(equalToSystemSpacingBelow: profilepicture.bottomAnchor, multiplier: 1),
                                     postImage.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 0),
                                     self.trailingAnchor.constraint(equalToSystemSpacingAfter: postImage.trailingAnchor, multiplier: 0)
        ])
        
        
        let stack = UIStackView(arrangedSubviews: [LikeButton,CommentButton,MessageButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 14
       
        self.addSubview(stack)
        
        NSLayoutConstraint.activate([stack.topAnchor.constraint(equalToSystemSpacingBelow: postImage.bottomAnchor, multiplier: 2),
                                     stack.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1)
            
        ])
        
        self.addSubview(savePostButton)
        NSLayoutConstraint.activate([self.trailingAnchor.constraint(equalToSystemSpacingAfter: savePostButton.trailingAnchor, multiplier: 2),
                                     savePostButton.topAnchor.constraint(equalToSystemSpacingBelow: postImage.bottomAnchor, multiplier: 2)
        ])
        
        self.addSubview(likesLabel)
        NSLayoutConstraint.activate([likesLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),
                                     likesLabel.topAnchor.constraint(equalToSystemSpacingBelow: stack.bottomAnchor, multiplier: 1),
                                     self.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.addSubview(captionMessage)
        NSLayoutConstraint.activate([captionMessage.topAnchor.constraint(equalToSystemSpacingBelow: likesLabel.bottomAnchor, multiplier: 1),
                                     captionMessage.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1)
        ])
        
        
        self.addSubview(timeLable)
        NSLayoutConstraint.activate([timeLable.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),
                                     self.bottomAnchor.constraint(equalToSystemSpacingBelow: timeLable.bottomAnchor, multiplier: 1)
        ])
    }
}

extension FeedCell
{
     func configureFeedCell()
    {
        guard let myPost = selectedPost else {return}
        guard let userid = myPost.user_id else {return}
        guard let PostImageUrl = myPost.post_url else {return}
        guard let likes = myPost.likes else {return}
        
        
        Services.shared.fetchUser(user_Id: userid) { user in
            self.profilepicture.loadImage(with: user.profileImage)
            self.usernameButton.setTitle(user.username ?? "", for: .normal)
            self.configureCaptionLabel(user: user)
        }
        postImage.loadImage(with: PostImageUrl)
        self.likesLabel.text = "\(likes) Likes"

        
    }
    
    private func configureCaptionLabel(user: User)
    {
         guard let myPost = selectedPost else {return}
        let attributted = NSMutableAttributedString(string: "\(user.username ?? "") ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributted.append(NSAttributedString(string: myPost.post, attributes: [.font:UIFont.systemFont(ofSize: 16)]))
        self.captionMessage.attributedText = attributted
    }
}

extension FeedCell
{
   func configureLikebutton()
   {
    self.LikeButton.setImage(UIImage(named: self.selectedPost!.didlike ? "like_selected":"like_unselected")?.withTintColor(self.selectedPost!.didlike ? .systemRed: .black, renderingMode: .alwaysOriginal), for: .normal)
    }
}
