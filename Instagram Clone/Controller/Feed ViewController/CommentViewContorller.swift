//
//  CommentViewContorller.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/03/01.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit


private let collectionviewcellID = "CollectionViewID"

class CommentViewContorller: UICollectionViewController
{

    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
}

extension CommentViewContorller: UICollectionViewDelegateFlowLayout
{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.commentCellID, for: indexPath) as? CommentCell else
        {return UICollectionViewCell()}
        
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
    
}

extension CommentViewContorller
{
    private func style()
    {
        self.collectionView.backgroundColor = .white
        self.collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.commentCellID)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.title = "Comments"
    }
    
    private func layout()
    {
         
    }
}

