//
//  FeedCell.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/02/17.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell
{
    
    static let FeedCellId = "FeedCellID"
    
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
            button.setTitle("Username", for: .normal)
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
            return propic
    }()
    
    
    
    lazy var LikeButton: UIButton =
        {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "like_unselected")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
            button.addTarget(self, action: #selector(HandleOptionPressed), for: .primaryActionTriggered)
            return button
    }()
    
    
    lazy var CommentButton: UIButton =
        {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "comment")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
            button.addTarget(self, action: #selector(HandleOptionPressed), for: .primaryActionTriggered)
            return button
    }()
    
    
    lazy var MessageButton: UIButton =
        { let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "send2")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
            button.addTarget(self, action: #selector(HandleOptionPressed), for: .primaryActionTriggered)
            return button
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
        print("DEBUG: USERNAME PRESSED")
    }
    
    @objc func HandleOptionPressed()
    {
        print("DEBUG: OPTIONS PRESSED")
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
                                     self.trailingAnchor.constraint(equalToSystemSpacingAfter: postImage.trailingAnchor, multiplier: 0),
                                     self.bottomAnchor.constraint(equalToSystemSpacingBelow: postImage.bottomAnchor, multiplier: 5)
        ])
        
        
        let stack = UIStackView(arrangedSubviews: [LikeButton,CommentButton,MessageButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        
        self.addSubview(stack)
        
        NSLayoutConstraint.activate([stack.topAnchor.constraint(equalToSystemSpacingBelow: postImage.bottomAnchor, multiplier: 1),
                                     stack.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1)
                            
        ])
        
    }
}
