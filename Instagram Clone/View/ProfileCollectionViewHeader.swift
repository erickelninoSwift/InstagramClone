//
//  ProfileCollectionViewHeader.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/25.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit

class ProfileCollectionViewHeader: UICollectionReusableView
{
    private let profileImageView : UIImageView =
    {
        let profileimage = UIImageView()
        profileimage.translatesAutoresizingMaskIntoConstraints = false
        profileimage.contentMode = .scaleAspectFill
        profileimage.clipsToBounds = true
        profileimage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileimage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileimage.layer.cornerRadius = 100 / 2
        
        return profileimage
    }()
    
    private let nameLabel : UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Eriik Elnino"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let postLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        
        let attributed = NSAttributedString(string: "Post", attributes: [.font: UIFont.systemFont(ofSize: 14),.foregroundColor:UIColor.lightGray])
        let MutabelAtributted = NSMutableAttributedString(string: "3 \n", attributes: [.font:  UIFont.boldSystemFont(ofSize: 16),.foregroundColor:UIColor.darkGray])
        MutabelAtributted.append(attributed)
        label.attributedText = MutabelAtributted
        
        return label
    }()
    
    private let FollowingLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        
        let attributed = NSAttributedString(string: "Following", attributes: [.font: UIFont.boldSystemFont(ofSize: 14),.foregroundColor:UIColor.lightGray])
        let MutabelAtributted = NSMutableAttributedString(string: "7 \n", attributes: [.font: UIFont.boldSystemFont(ofSize: 16),.foregroundColor:UIColor.darkGray])
        MutabelAtributted.append(attributed)
        label.attributedText = MutabelAtributted
        return label
    }()
    
    
    private let FollowerLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        
        let attributed = NSAttributedString(string: "Followers", attributes: [.font: UIFont.systemFont(ofSize: 14),.foregroundColor:UIColor.lightGray])
        let MutabelAtributted = NSMutableAttributedString(string: "5 \n", attributes: [.font: UIFont.boldSystemFont(ofSize: 16),.foregroundColor:UIColor.darkGray])
        MutabelAtributted.append(attributed)
        label.attributedText = MutabelAtributted
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        configured()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ProfileCollectionViewHeader
{
    private func style()
    {
      
        self.translatesAutoresizingMaskIntoConstraints = false
        self.profileImageView.backgroundColor = .darkGray
        self.addSubview(profileImageView)
        self.addSubview(nameLabel)
        
        
        
        
    }
    
    private func layout()
    {
        let stack = UIStackView(arrangedSubviews: [postLabel,FollowingLabel,FollowerLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        
        self.addSubview(stack)
        
        NSLayoutConstraint.activate([profileImageView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 3),
                                     profileImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: profileImageView.bottomAnchor, multiplier: 1),
                                     nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([stack.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
                                     stack.leadingAnchor.constraint(equalToSystemSpacingAfter: profileImageView.trailingAnchor, multiplier: 3),
                                     self.trailingAnchor.constraint(equalToSystemSpacingAfter: stack.trailingAnchor, multiplier: 2)
        ])
    }
    
    private func configured()
    {
        
    }
}
