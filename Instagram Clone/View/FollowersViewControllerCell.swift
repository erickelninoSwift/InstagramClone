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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        config()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FollowersViewControllerCell
{
    private func config()
    {
        self.profileImage.backgroundColor = .systemBlue
        contentView.addSubview(profileImage)
    }
    
    
    private func layout()
    {
        NSLayoutConstraint.activate([profileImage.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 2),
                                     profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
}
