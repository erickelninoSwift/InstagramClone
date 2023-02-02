//
//  FollowersVC.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/02/02.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit
enum followVCconfig
{
    case following
    case follower
    case post
    
    var description: String
    {
        switch self
        {
        case .follower:
            return "Followers"
        case .following:
            return "Following"
        case .post:
            return "Post"
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
}
