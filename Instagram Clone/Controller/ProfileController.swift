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
    {
        didSet
        {
            checkifuserfollwing()
        }
    }
    
    var userfromsearchVC: User?
    {
        didSet
        {
            checkifuserfollwing()
        }
        
    }
    
    var profileconfig: configurationEditbutton?
    
    
    
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
            
            switch profileconfig!
            {
            case .editprofile:
                header.delegate = self
                header.currentUser = myuser
                self.navigationItem.title = myuser.username ?? ""
                header.configurationset = profileconfig
                
                
                
            case .followuser:
                
                header.delegate = self
                header.currentUser = myuser
                self.navigationItem.title = myuser.username ?? ""
                header.configurationset = profileconfig
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
    func handleGrid(CurrentButton: UIButton, profileheader: ProfileCollectionViewHeader) {
        print("DEBUG: \(CurrentButton.currentTitle!) Here We go")
    }
    
    func handleListController(CurrentButton: UIButton, profileheader: ProfileCollectionViewHeader) {
        print("DEBUG: \(CurrentButton.currentTitle!) you will never walk alone")
    }
    
    func HandleBookmark(CurrentButton: UIButton, profileheader: ProfileCollectionViewHeader) {
        print("DEBUG: \(CurrentButton.currentTitle!)Make more money then avoid bitches")
    }
    
    func HandleeditFollow(profileheader: ProfileCollectionViewHeader, buttonConfig: configurationEditbutton) {
        
        if let profileuser = profileheader.currentUser
        {
            switch buttonConfig
            {
            case .editprofile:

                profileheader.currentUser = profileuser
                self.navigationItem.title = profileuser.username ?? ""
                profileheader.configurationset = buttonConfig
                
            case .followuser:
                
                profileheader.currentUser = profileuser
                self.navigationItem.title = profileuser.username ?? ""
                profileheader.configurationset = buttonConfig
                
                if profileheader.editFollowButton.titleLabel?.text == "Follow"
                {
                    profileheader.editFollowButton.setTitle("Following", for: .normal)
                    FollowUnFollow.userisFollowed = true
                    FollowUnFollow.shared.followUser(usertoFollow: profileuser)
                }else
                {
                    profileheader.editFollowButton.setTitle("Follow", for: .normal)
                    FollowUnFollow.userisFollowed = false
                    FollowUnFollow.shared.UnfollowUser(usertoUnfollow: profileuser)
                    
                }
            }
        }
    }
}

extension ProfileController
{
    func checkifuserfollwing()
       {
           guard let current = user else {return}
           guard let myUID = Auth.auth().currentUser?.uid else {return}
           
           if current.userID != myUID
           {
               current.checkuserFollow(myUser: current, myuserID: myUID, completion: { isFollowed in
                   current.isFollowed = isFollowed
                self.collectionView.reloadData()
               })
           }
       }
}
