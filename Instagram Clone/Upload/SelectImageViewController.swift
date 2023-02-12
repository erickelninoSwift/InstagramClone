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
//        collectionView.register(SelectPhotoHeaderCell.self, forSupplementaryViewOfKind: ,SelectPhotoHeaderCell.photoheaderID)
        collectionView.register(SelectPhotoCell.self, forCellWithReuseIdentifier: SelectPhotoCell.selectphotocellID)
       
    }
    
    
    private func layout()
    {
        self.collectionView.backgroundColor = .systemPurple
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectPhotoCell.selectphotocellID, for: indexPath) as? SelectPhotoCell else {return UICollectionViewCell()}
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header  =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SelectPhotoHeaderCell.photoheaderID, for: indexPath) as? SelectPhotoHeaderCell else {return UICollectionViewCell()}
        
        return header
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
}
