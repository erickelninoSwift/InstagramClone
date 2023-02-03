//
//  FollowersViewControllerCell.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/02/02.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit

class FollowersViewControllerCell: UITableViewCell
{
    
    var configureCell: followVCconfig?
    {
        didSet
        {
            tableviewCellConfig()
        }
    }
    var currentUser: User?
    {
        didSet
        {
            tableviewCellConfig()
        }
    }
    
    private lazy var profileImage: UIImageView =
    {
        let profile = UIImageView()
        profile.translatesAutoresizingMaskIntoConstraints = false
        profile.clipsToBounds = true
        profile.layer.masksToBounds = true
        profile.contentMode = .scaleAspectFill
        profile.heightAnchor.constraint(equalToConstant: 60).isActive = true
        profile.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        profile.layer.cornerRadius = 60 / 2
        
        return profile
    }()
    
    lazy var followButton: UIButton =
    {
        let button  = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(HandleFollowButton), for: .primaryActionTriggered)
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        config()
        layout()
        textLabel?.text = "Username"
        detailTextLabel?.text = "Fullname"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.frame = CGRect(x: 85, y: textLabel!.frame.origin.y, width: (textLabel?.frame.width ?? 100) + 100, height: textLabel?.frame.height ?? 20)
        textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        detailTextLabel?.frame = CGRect(x: 85, y: detailTextLabel!.frame.origin.y + 2, width: (detailTextLabel?.frame.width ?? 100) + 100, height: detailTextLabel?.frame.height ?? 20)
        detailTextLabel?.textColor = .lightGray
        detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    @objc func HandleFollowButton()
    {
        guard let currentConfig = configureCell else {return}
//        guard let currentUserSelected = currentUser else {return}
        
        switch currentConfig
        {
        case .follower:
           
            print("DEBUG: Follow bruv!!!")
        case .following:
          
            print("DEBUG: Following bruv!!!")
        case .post:

            print("DEBUG: Post bruv!!!")
        }
    }
}

extension FollowersViewControllerCell
{
    private func config()
    {
        self.profileImage.backgroundColor = .systemBlue
        contentView.addSubview(profileImage)
        contentView.addSubview(followButton)
    }
    
    
    private func layout()
    {
        NSLayoutConstraint.activate([profileImage.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 2),
                                     profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([self.trailingAnchor.constraint(equalToSystemSpacingAfter: followButton.trailingAnchor, multiplier: 1),
                                     followButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     followButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    func tableviewCellConfig()
    {
        guard let currentConfig = configureCell else {return}
        guard let currentUserSelected = currentUser else {return}
        
        switch currentConfig
        {
        case .follower:
           
            self.followButton.setTitle("Follow", for: .normal)
        case .following:
          
            self.followButton.setTitle(currentConfig.description, for: .normal)
        case .post:

            self.followButton.setTitle("View", for: .normal)
        }
    }
}
