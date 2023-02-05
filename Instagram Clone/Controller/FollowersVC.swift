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
    
    var description: String
    {
        switch self
        {
        case .follower:
            return "Followers"
        case .following:
            return "Following"
        }
    }
}
private let followersCellID = "Erickelninojackpot"

class FollowersVC: UITableViewController
{
    
    
    private var viewcontrollerConfig: followVCconfig = .follower
    
    private var userFollowers: User?
    
    var userfetched = [User]()
    
    init(style: UITableView.Style, followconfig:followVCconfig , userSelected: User) {
        self.viewcontrollerConfig = followconfig
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
        guard let currentuser = userFollowers else {return}
        print("DEBUG: The user received from the profile controller is : \(currentuser.fullname ?? "")")
    }
    
    func fetchUser()
    {
        guard let userpassed = userFollowers else {return}
        
        var dataref: DatabaseReference!
        
        switch viewcontrollerConfig
        {
        case .follower:
            dataref = Database.database().reference().child("User-followers")
            
        case .following:
            dataref = Database.database().reference().child("User-following")
            
        }
        
        dataref.child(userpassed.userID!).observeSingleEvent(of: .value) { snapshots in
            
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
        
//                if cellconfig == .follower
//                {
//
//                    FollowUnFollow.shared.followUser(usertoFollow: cellFollow.currentUser!)
//                    cellFollow.followButton.setTitle("Following", for: .normal)
//                    cellFollow.followButton.backgroundColor = .white
//                    cellFollow.followButton.setTitleColor(.black, for: .normal)
//                    cellFollow.followButton.layer.borderColor = UIColor.lightGray.cgColor
//                    cellFollow.followButton.layer.borderWidth = 0.5
//
//                }else
//                {
//
//                    FollowUnFollow.shared.UnfollowUser(usertoUnfollow: cellFollow.currentUser!)
//                    cellFollow.followButton.setTitle("Follow", for: .normal)
//                    cellFollow.followButton.backgroundColor =  UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
//                    cellFollow.followButton.setTitleColor(.white, for: .normal)
//                    cellFollow.followButton.layer.borderWidth = 0
//                }
        
        guard let myuser = cellFollow.currentUser else {return}
        
        if myuser.isFollowed
        {
           print("DEBUG: Should unfollow")
            print("DEBUG:\(myuser.isFollowed)")
        }else
        {
            print("DEBUG: Should be following by now")
              print("DEBUG:\(myuser.isFollowed)")
        }
    }
   
}
