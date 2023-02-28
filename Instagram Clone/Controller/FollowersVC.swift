//
//  FollowersVC.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/02/02.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit
import Firebase

enum followVCconfig
{
    case following
    case follower
    case Likes
    
    var description: String
    {
        switch self
        {
        case .follower:
            return "Followers"
        case .following:
            return "Following"
        case .Likes:
            return "Likes"
        }
    }
}

private let followersCellID = "Erickelninojackpot"

class FollowersVC: UITableViewController
{
    
    
    private var viewcontrollerConfig: followVCconfig = .follower
  
    
    private var userFollowers: User?
    
    private var selectedPost: Post?
    
    var userfetched = [User]()
    
    init(style: UITableView.Style, followconfig:followVCconfig, userSelected: User , post: Post?) {
        self.viewcontrollerConfig = followconfig
        self.selectedPost = post
        self.userFollowers = userSelected
        super.init(style: style)
        self.navigationItem.title = self.viewcontrollerConfig.description
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fetchUser()
        configureUser()
        style()
        layout()
        
    }
}

extension FollowersVC
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userfetched.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: followersCellID, for: indexPath) as? FollowersViewControllerCell else {return UITableViewCell()}
    
        cell.delegate = self
        if let myUserSelected  = userFollowers
        {
            cell.configureCell = viewcontrollerConfig
            cell.currentUser = userfetched[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let myUser = userfetched[indexPath.row]
        let controller = ProfileController(collectionViewLayout: UICollectionViewFlowLayout(), config: .followuser)
        controller.userfromsearchVC = myUser
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}

extension FollowersVC
{
    private func style()
    {
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        self.tableView.register(FollowersViewControllerCell.self, forCellReuseIdentifier: followersCellID)
    }
    
    
    private func layout()
    {
        
    }
    
    func configureUser()
    {
//        guard let currentuser = userFollowers else {return}
       
    }
    
    func fetchUser()
    {
        guard let userpassed = userFollowers else {return}
        
        var dataref: DatabaseReference!
        
        switch viewcontrollerConfig
        {
        case .follower:
            dataref = Database.database().reference().child("User-followers")
            configureUser(fetchuserid: userpassed.userID ?? "", Databaaee: dataref)
            
        case .following:
            dataref = Database.database().reference().child("User-following")
             configureUser(fetchuserid: userpassed.userID ?? "", Databaaee: dataref)
        case .Likes:
           
            guard let currentPost = selectedPost else {return}
            self.navigationItem.title = "Likes"
            self.navigationController?.navigationBar.tintColor = .black
            Database.database().reference().child("Post-likes").child(currentPost.post_ID).observe(.childAdded) { snapshotkey in
                let UserLikePost = snapshotkey.key
                Database.database().reference().child("Users").child(UserLikePost).observeSingleEvent(of: .value) { UserSnapshots in
                    guard let signleUser = UserSnapshots.value as? [String:Any] else {return}
                    print("DEBUG: USER :\(signleUser)")
                }
            }
        }
        
        
    }
    
    
    func fetchLikes()
    {
        
    }
    
    func configureUser(fetchuserid : String, Databaaee: DatabaseReference)
    {
        Databaaee.child(fetchuserid).observeSingleEvent(of: .value) { snapshots in
            
            guard let Allobject = snapshots.children.allObjects as? [DataSnapshot]  else {return}
            
            Allobject.forEach { Mysnapshots in
                Services.shared.fetchUser(user_Id: Mysnapshots.key) { user in
                    self.userfetched.append(user)
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension FollowersVC: FollowCellDelegate
{
    func handleFollowandUnfollowButtonTapped(cellFollow: FollowersViewControllerCell, cellconfig: followVCconfig) {
        
        
        guard let currentuserselected = cellFollow.currentUser else {return}
        
        
        if cellFollow.followButton.titleLabel?.text == "Following"
        {
            FollowUnFollow.shared.UnfollowUser(usertoUnfollow: currentuserselected)

            
            buttonSetting(followButton: cellFollow, title: "Follow", buttonbackground: UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
                , titlebutton: .white, borderwith: 1, buttonLayerColor: .white)
            
        }else if cellFollow.followButton.titleLabel?.text == "Follow"
        {
            FollowUnFollow.shared.followUser(usertoFollow: currentuserselected)
            
            buttonSetting(followButton: cellFollow, title: "Following", buttonbackground: .white
            , titlebutton: .black, borderwith: 1, buttonLayerColor: .darkGray)
            
        }
    }
    
    func buttonSetting(followButton: FollowersViewControllerCell,title: String , buttonbackground: UIColor , titlebutton: UIColor, borderwith: CGFloat, buttonLayerColor: UIColor)
    {
        followButton.followButton.setTitle(title, for: .normal)
        followButton.followButton.backgroundColor = buttonbackground
        followButton.followButton.setTitleColor(titlebutton, for: .normal)
        followButton.followButton.layer.borderColor = buttonLayerColor.cgColor
        followButton.followButton.layer.borderWidth = borderwith
    }
   
}
