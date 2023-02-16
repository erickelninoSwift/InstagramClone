//
//  ProfilePostCell.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/02/16.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit



class ProfilePostCell: UICollectionViewCell
{
    
    
    var myPost: Post?
    {
        didSet
        {
            configureCell()
        }
    }
    
    static let ProfilePostid = "ProfilePostCell"
    lazy var postImageView: UIImageView =
    {
        let postimage =  UIImageView()
        postimage.translatesAutoresizingMaskIntoConstraints = false
        postimage.clipsToBounds = true
        postimage.layer.masksToBounds = true
        postimage.contentMode = .scaleAspectFill
        postimage.backgroundColor = .lightGray
        return postimage
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




extension ProfilePostCell
{
    private func style()
    {
        self.addSubview(postImageView)
    }
    
    
    private func layout()
    {
        NSLayoutConstraint.activate([postImageView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 0),
                                     postImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 0),
                                     self.trailingAnchor.constraint(equalToSystemSpacingAfter: postImageView.trailingAnchor, multiplier: 0),
                                     self.bottomAnchor.constraint(equalToSystemSpacingBelow: postImageView.bottomAnchor, multiplier: 0)
        ])
        
    }
    
    
    private func configureCell()
    {
        guard let imageurl = myPost?.post_url else {return}
        self.postImageView.loadImage(with: imageurl)
    }
}
