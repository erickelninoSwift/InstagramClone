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
private let headerprofileID = "ProfileviewHeader"
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
         self.collectionView.register(ProfileCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerprofileID)
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
        
    }
}
extension ProfileController
{
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileIDcell, for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerprofileID, for: indexPath) as? ProfileCollectionViewHeader else {return UICollectionReusableView()}
        
        return header
    }
    
    
}
// API CALLS

extension ProfileController
{
    private func fetchCurrentuser()
    {
        guard let currentUSerID = Auth.auth().currentUser?.uid else {return}

        Database.database().reference().child("Users").child(currentUSerID).observeSingleEvent(of: .value) { snapshots in
            guard let datadictionary = snapshots.value as? [String:Any] else {return}
            guard let currentusername = datadictionary["Username"] as? String else {return}
            self.navigationItem.title = "\(currentusername)"
        }
    }
}

extension ProfileController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
}
