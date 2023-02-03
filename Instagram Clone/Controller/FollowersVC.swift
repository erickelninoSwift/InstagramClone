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
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: followersCellID, for: indexPath) as? FollowersViewControllerCell else {return UITableViewCell()}
       if let myUserSelected  = userFollowers
       {
          cell.configureCell = viewcontrollerConfig
          cell.currentUser = myUserSelected
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
        
        dataref.child(userpassed.userID!).observe(.childAdded) { snapshots in
            let currentUserID = snapshots.key as String
            print("DEBUG: Currentid: \(currentUserID)")
            Services.shared.fetchUser(user_Id: currentUserID) { userFetched in
                print("DEBUG: USER INFO: \(userFetched.fullname)")
            }
        }
        
        
    }
}
