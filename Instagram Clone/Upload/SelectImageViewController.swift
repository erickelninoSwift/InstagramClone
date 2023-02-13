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
        collectionView.register(SelectPhotoHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SelectPhotoHeaderCell.photoheaderID)
        collectionView.register(SelectPhotoCell.self, forCellWithReuseIdentifier: SelectPhotoCell.selectphotocellID)
    }
    
    
    private func layout()
    {
        self.collectionView.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(HansleCancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(HandleDone))
        self.navigationController?.navigationBar.tintColor = .black
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
    
    
    // Functions needed to setup Collection views
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 3) / 4, height: (view.frame.width - 3) / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension SelectImageViewController
{
    @objc func HansleCancel()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func HandleDone()
    {
        print("DEBUG: Done!!!!")
    }
}
