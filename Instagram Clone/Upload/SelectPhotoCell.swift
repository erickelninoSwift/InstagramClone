//
//  SelectPhotoCell.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/02/11.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit

class SelectPhotoCell: UICollectionViewCell
{
    
    static let selectphotocellID = "SelectPhotoCell"
    
    lazy var photocellimage: UIImageView =
    {
        let propic = UIImageView()
        propic.translatesAutoresizingMaskIntoConstraints = false
        propic.clipsToBounds  = true
        propic.layer.masksToBounds = true
        propic.contentMode = .scaleAspectFill
        propic.backgroundColor = .darkGray
        return propic
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension SelectPhotoCell
{
    private func style()
    {
        self.addSubview(photocellimage)
    }
    
    
    private func layout()
    {
        photocellimage.frame = self.bounds
    }
}
