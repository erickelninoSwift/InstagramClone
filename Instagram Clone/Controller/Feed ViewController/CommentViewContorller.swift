//
//  CommentViewContorller.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/03/01.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit

class CommentViewContorller: UICollectionViewController
{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}
extension CommentViewContorller
{
    private func style()
    {
        self.collectionView.backgroundColor = .systemBlue
    }
    
    private func layout()
    {
        
    }
}
