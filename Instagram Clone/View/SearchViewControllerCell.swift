//
//  SearchViewControllerCell.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/27.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit

class SearchViewControllerCell: UITableViewCell
{
    static let searchcellid = "SearchViewControllerCell"
    
    
    private let profilepic: UIImageView =
    {
        let propic = UIImageView()
        propic.translatesAutoresizingMaskIntoConstraints = false
        propic.clipsToBounds = true
        propic.contentMode = .scaleAspectFill
        
        
        NSLayoutConstraint.activate([propic.heightAnchor.constraint(equalToConstant: 60),
                                     propic.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        propic.layer.cornerRadius = 60 / 2
        
        propic.backgroundColor = .systemBlue
        
        return propic
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureationCell()
        layout()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SearchViewControllerCell
{
    private func configureationCell()
    {
     
        self.addSubview(profilepic)
    }
    
    
    private func layout()
    {
        NSLayoutConstraint.activate([profilepic.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     profilepic.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 2)
        ])
    }
}

extension SearchViewControllerCell
{
    fileprivate func configure()
    {
        
    }
}
