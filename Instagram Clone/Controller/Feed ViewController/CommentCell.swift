//
//  CommentCell.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/03/01.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell
{
    static let commentCellID = "CommentCellIdentifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommentCell
{
    private func style()
    {
        self.backgroundColor = .cyan
    }
    
    
    private func layout()
    {
        
    }
}
