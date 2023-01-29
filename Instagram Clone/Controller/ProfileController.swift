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
    var user: UserModel?
    {
        didSet
        {
            guard let currentuser = user else {return }
            print("DEBUG: User was set from the mainTabBar \(currentuser)")
            fetchuser()
        }
    }
    
    var userfromsearchVC: UserModel?
    
    
    override init(collectionViewLayout layout: UICollectionViewLayout)
    {
        super.init(collectionViewLayout: layout)
//        fetchuser()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = user?.username ?? ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: profileIDcell)
        self.collectionView.register(ProfileCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerprofileID)
        
        if let userfromSearch = self.userfromsearchVC
        {
            print("DEBUG: USER FROM SEARCH : \(userfromSearch.fullname ?? "")")
        }
        
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
        guard let usertosend = user else {return UICollectionReusableView()}
        header.currentUser = usertosend
        self.navigationItem.title = usertosend.username ?? ""
        return header
    }
    
    
}
// API CALLS
extension ProfileController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
}

extension ProfileController
{
    private func fetchuser()
    {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        Services.shared.fetchUser(user_Id: userID) { MyUSer in
            self.user = MyUSer
            self.collectionView.reloadData()
        }
    }
}
