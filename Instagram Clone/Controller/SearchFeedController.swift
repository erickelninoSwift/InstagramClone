//
//  SearchFeedController.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/24.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class SearchFeedController: UITableViewController
{
    private let searchbar = UISearchController(searchResultsController: nil)
    
    
    private var userCollection = [UserModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Search"
        style()
        layout()
        getAllusers()
    }
    
}
extension SearchFeedController
{
    fileprivate func style()
    {
        self.tableView.register(SearchViewControllerCell.self, forCellReuseIdentifier: SearchViewControllerCell.searchcellid)
        self.tableView.rowHeight = 80
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 0)
        navigationItem.searchController = searchbar
    }
    
    
    fileprivate func layout()
    {
        
    }
}

extension SearchFeedController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCollection.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewControllerCell.searchcellid, for: indexPath) as? SearchViewControllerCell else {return UITableViewCell()}
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension SearchFeedController
{
    fileprivate func getAllusers()
    {
        DispatchQueue.main.async {
            Database.database().reference().child("Users").observe(.childAdded) { snapshots in
                Services.shared.fetchUser(user_Id: snapshots.key) { user in
                   
                    self.userCollection.append(user)
                    self.tableView.reloadData()
                }
            }
        }
    }
}
