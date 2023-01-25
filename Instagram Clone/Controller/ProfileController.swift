//
//  ProfileController.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/24.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit
import Firebase

private let profileIDcell = "ProfileViewcontrollerID"

class ProfileController: UICollectionViewController
{
    

    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
       fetchCurrentuser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         style()
         self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: profileIDcell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProfileController
{
    private func style()
    {
        self.collectionView.backgroundColor = .white
        self.title = "Profile"
    }
}
extension ProfileController
{
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileIDcell, for: indexPath)
        return cell
    }
}
// API CALLS

extension ProfileController
{
    private func fetchCurrentuser()
    {
        guard let currentUSerID = Auth.auth().currentUser?.uid else {return}
        print("DEBUG: Current User ID: \(currentUSerID)")
        Database.database().reference().child("Users").child(currentUSerID).observeSingleEvent(of: .childAdded) { snapshots in
            
        }
    }
}

