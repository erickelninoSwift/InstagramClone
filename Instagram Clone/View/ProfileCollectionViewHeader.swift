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
        self.backgroundColor = .lightGray
        self.translatesAutoresizingMaskIntoConstraints = false
        self.profileImageView.backgroundColor = .systemRed
        self.addSubview(profileImageView)
    }
    
    private func layout()
    {
        NSLayoutConstraint.activate([profileImageView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 3),
                                     profileImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 2)
        ])
    }
    
    private func configured()
    {
        
    }
}
