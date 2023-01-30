//
//  ProfileController.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/24.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit
import Firebase
enum configurationEditbutton: String
{
    case editprofile
    case followuser
    
    var description: String
    {
        switch self {
        case .editprofile:
            return "Edit Profile"
        case .followuser:
            return "Follow"
        }
    }
}

private let profileIDcell = "ProfileViewcontrollerID"
private let headerprofileID = "ProfileviewHeader"

class ProfileController: UICollectionViewController
{
    
    var user: User?
    
    var userfromsearchVC: User?
    
    var profileconfig: configurationEditbutton = .editprofile
    
    
    
    init(collectionViewLayout layout: UICollectionViewLayout, config: configurationEditbutton)
    {
        self.profileconfig = config
        super.init(collectionViewLayout: layout)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = user?.username ?? ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: profileIDcell)
        self.collectionView.register(ProfileCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerprofileID)
        
        
        if let currentUSerSelected = userfromsearchVC
        {
            self.user = currentUSerSelected
        }else
        {
            self.fetchuser()
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
        self.navigationController?.navigationBar.tintColor = .black
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
        if let myuser = user
        {
            switch self.profileconfig
            {
            case .editprofile:
                header.currentUser = myuser
                self.navigationItem.title = myuser.username ?? ""
                header.configurationset = self.profileconfig
                break
            case .followuser:
                header.currentUser = myuser
                self.navigationItem.title = myuser.username ?? ""
                header.configurationset = self.profileconfig
                break
            }
        }
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
extension ProfileController: ProfileCollectionViewHeaderDelegate
{
    func HandleeditFollow(profileheader: ProfileCollectionViewHeader) {
        print("DEBUG: EDIT AND FOLLOW")
    }
}
