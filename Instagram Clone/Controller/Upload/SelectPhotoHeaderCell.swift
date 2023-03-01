//
//  SelectPhotoHeaderCell.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/02/11.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit

class SelectPhotoHeaderCell: UICollectionReusableView
{
    
    lazy var profileImageView: UIImageView =
        {
            let propic = UIImageView()
            propic.translatesAutoresizingMaskIntoConstraints = false
            propic.clipsToBounds = true
            propic.layer.masksToBounds = true
            propic.contentMode = .scaleAspectFill

            
            return propic
    }()
    
    static let photoheaderID = "SelectPhotoHeaderCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    
    override var intrinsicContentSize: CGSize
    {
        return CGSize(width: UIView.noIntrinsicMetric, height: 350)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension SelectPhotoHeaderCell
{
    private func style()
    {
        self.addSubview(profileImageView)
    }
    
    
    private func layout()
    {
        NSLayoutConstraint.activate([profileImageView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 0),
                                     profileImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 0),
                                     self.trailingAnchor.constraint(equalToSystemSpacingAfter: profileImageView.trailingAnchor, multiplier: 0),
                                     self.bottomAnchor.constraint(equalToSystemSpacingBelow: profileImageView.bottomAnchor, multiplier: 0.25)
        ])
        
    }
}
