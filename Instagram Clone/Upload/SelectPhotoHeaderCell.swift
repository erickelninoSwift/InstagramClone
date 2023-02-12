//
//  SelectPhotoHeaderCell.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/02/11.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit

class SelectPhotoHeaderCell: UICollectionViewCell
{
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
        self.backgroundColor = .white
    }
    
    
    private func layout()
    {
        
    }
}
