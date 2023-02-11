//
//  SelectImageViewController.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/02/11.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit


class SelectImageViewController: UICollectionViewController
{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
}

extension SelectImageViewController: UICollectionViewDelegateFlowLayout
{
    
    private  func style()
    {
        collectionView.register(SelectPhotoCell.self, forCellWithReuseIdentifier: SelectPhotoCell.selectphotocellID)
       
    }
    
    
    private func layout()
    {
        
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}
