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
    
    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = .white
        navigationItem.title = "Search"
        style()
        layout()
    }
}
extension SearchFeedController
{
    fileprivate func style()
    {
        self.tableView.register(SearchViewControllerCell.self, forCellReuseIdentifier: SearchViewControllerCell.searchcellid)
        self.tableView.rowHeight = 80
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        
        self.searchbar.delegate = self
        navigationItem.searchController = searchbar
    }
    
    
    fileprivate func layout()
    {
        
    }
}

extension SearchFeedController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewControllerCell.searchcellid, for: indexPath) as? SearchViewControllerCell else {return UITableViewCell()}
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchFeedController: UISearchControllerDelegate, UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.showsCancelButton = false
    }
    
}
