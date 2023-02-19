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
    
    var AllmyPost = [Post]()
    
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
            fetchAllpost()
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
        self.collectionView.register(ProfilePostCell.self, forCellWithReuseIdentifier: ProfilePostCell.ProfilePostid)
    }
}
extension ProfileController
{
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AllmyPost.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: ProfilePostCell.ProfilePostid, for: indexPath) as? ProfilePostCell else {return UICollectionViewCell()}
        cell.myPost = AllmyPost[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerprofileID, for: indexPath) as? ProfileCollectionViewHeader else {return UICollectionReusableView()}
        
        if let myuser = user
        {
            
            switch profileconfig!
            {
                
            case .editprofile:
                self.getuserStats(user_id: myuser.userID!, profile: header)
                header.delegate = self
                header.labelActionDelegate = self
                header.currentUser = myuser
                self.navigationItem.title = myuser.username ?? ""
                header.configurationset = profileconfig
                
                
                
            case .followuser:
                
                self.getuserStats(user_id: myuser.userID!, profile: header)
                header.delegate = self
                header.labelActionDelegate = self
                header.currentUser = myuser
                self.navigationItem.title = myuser.username ?? ""
                header.configurationset = profileconfig
            }
        }
        return header
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPost  = AllmyPost[indexPath.row]
        
        let controller = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.viewSinglePost = true
        controller.myPost = selectedPost
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
// API CALLS
extension ProfileController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 2) / 3, height: (view.frame.width - 2) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
    
}

extension ProfileController
{
    private func fetchuser()
    {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        Services.shared.fetchUser(user_Id: userID) { MyUSer in
            self.user = MyUSer
            self.fetchAllpost()
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
                self.getuserStats(user_id: profileuser.userID!, profile: profileheader)
                profileheader.currentUser = profileuser
                self.navigationItem.title = profileuser.username ?? ""
                profileheader.configurationset = buttonConfig
                checkifuserfollwing()
                
            case .followuser:
                
                profileheader.currentUser = profileuser
                self.navigationItem.title = profileuser.username ?? ""
                profileheader.configurationset = buttonConfig
                
                if profileheader.editFollowButton.titleLabel?.text == "Follow"
                {
                    profileheader.editFollowButton.setTitle("Following", for: .normal)
                    FollowUnFollow.shared.userisFollowed = true
                    FollowUnFollow.shared.followUser(usertoFollow: profileuser)
                    self.getuserStats(user_id: profileuser.userID!, profile: profileheader)
                    checkifuserfollwing()
                }else
                {
                    profileheader.editFollowButton.setTitle("Follow", for: .normal)
                    FollowUnFollow.shared.userisFollowed = false
                    FollowUnFollow.shared.UnfollowUser(usertoUnfollow: profileuser)
                    self.getuserStats(user_id: profileuser.userID!, profile: profileheader)
                    checkifuserfollwing()
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
                self.user?.isFollowed = isFollowed
                self.collectionView.reloadData()
            })
        }
    }
}

extension ProfileController
{
    
    
    func getuserStats(user_id: String, profile: ProfileCollectionViewHeader)
    {
        var userNumberOfFollowers:Int!
        var userNumberOfFollowing: Int!
        
        
        Database.database().reference().child("User-followers").child(user_id).observe(.value) { snapshots in
            if let numberOfStats = snapshots.value as? [String:Any]
            {
                userNumberOfFollowers = numberOfStats.count
            }else
            {
                userNumberOfFollowers = 0
            }
            
            let attributed = NSAttributedString(string: "Followers", attributes: [.font: UIFont.systemFont(ofSize: 14),.foregroundColor:UIColor.lightGray])
            let MutabelAtributted = NSMutableAttributedString(string: "\(userNumberOfFollowers ?? 0) \n", attributes: [.font: UIFont.boldSystemFont(ofSize: 16),.foregroundColor:UIColor.darkGray])
            MutabelAtributted.append(attributed)
            profile.FollowerLabel.attributedText = MutabelAtributted
        }
        
        Database.database().reference().child("User-following").child(user_id).observe(.value) { snapshots in
            if let numberOfStats = snapshots.value as? [String:Any]
            {
                userNumberOfFollowing = numberOfStats.count
            }else
            {
                userNumberOfFollowing = 0
            }
            
            let attributed = NSAttributedString(string: "Following", attributes: [.font: UIFont.boldSystemFont(ofSize: 14),.foregroundColor:UIColor.lightGray])
            let MutabelAtributted = NSMutableAttributedString(string: "\(userNumberOfFollowing ?? 0) \n", attributes: [.font: UIFont.boldSystemFont(ofSize: 16),.foregroundColor:UIColor.darkGray])
            MutabelAtributted.append(attributed)
            profile.FollowingLabel.attributedText = MutabelAtributted
        }
        
    }
    
}

extension ProfileController: profileheaderLabelActionDelegate
{
    func HandlePostLabel(userProfileHeader: ProfileCollectionViewHeader) {
        
    }
    func HandleFollowingLabel(userProfileHeader: ProfileCollectionViewHeader) {
        guard let currentuser = userProfileHeader.currentUser else {return}
        let controller = FollowersVC(style: .plain, followconfig: .following, userSelected: currentuser)
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func HandleFollowersLabel(userProfileHeader: ProfileCollectionViewHeader) {
        
        guard let currentuser = userProfileHeader.currentUser else {return}
        
        let controller = FollowersVC(style: .plain, followconfig: .follower, userSelected: currentuser)
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ProfileController
{
    func fetchAllpost()
    {
        guard let currentId = Auth.auth().currentUser?.uid else {return}
        
        switch profileconfig
        {
        case .editprofile:
            
            DispatchQueue.main.async {
                Database.database().reference().child("User-posts").child(currentId).observe(.childAdded) { datasnaping in
                    Services.shared.fetchPost(userid: currentId, postid: datasnaping.key) { myPost in
                        self.AllmyPost.append(myPost)
                        self.AllmyPost.sort { (post1, post2) -> Bool in
                            return post1.date > post2.date
                        }
                        self.collectionView.reloadData()
                    }
                }
            }
            
        case .followuser:
            DispatchQueue.main.async {
                Database.database().reference().child("User-posts").child(self.user?.userID ?? "").observe(.childAdded) { datasnaping in
                    Services.shared.fetchPost(userid: self.user?.userID ?? "", postid: datasnaping.key) { myPost in
                        self.AllmyPost.append(myPost)
                        self.AllmyPost.sort { (post1, post2) -> Bool in
                            return post1.date > post2.date
                        }
                        self.collectionView.reloadData()
                    }
                }
            }
        case .none:
            print("DEBUg: none")
        }
        
    }
    
    
    
}

