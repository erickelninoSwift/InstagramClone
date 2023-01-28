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
    
    
    private let usernameLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Erick Elnino"
        label.textColor = .darkGray
        
        return label
    }()
    
    
    private let FullnameLabrl: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.text = "Jackpot"
        label.textColor = .lightGray
        
        return label
    }()
    
    private let bottomlineView: UIView =
    {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
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
        let stackview = UIStackView(arrangedSubviews: [usernameLabel,FullnameLabrl])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 5
        stackview.distribution = .fillEqually
        
        self.addSubview(stackview)
//        self.addSubview(bottomlineView)
//
        
        NSLayoutConstraint.activate([profilepic.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     profilepic.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([stackview.centerYAnchor.constraint(equalTo: profilepic.centerYAnchor),
                                     stackview.leadingAnchor.constraint(equalToSystemSpacingAfter: profilepic.trailingAnchor, multiplier: 3)
        ])
        
//        NSLayoutConstraint.activate([bottomlineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//                                     bottomlineView.leadingAnchor.constraint(equalTo: stackview.leadingAnchor),
//                                     self.trailingAnchor.constraint(equalToSystemSpacingAfter: bottomlineView.trailingAnchor, multiplier: 0)
//        ])
        
    }
}

extension SearchViewControllerCell
{
    fileprivate func configure()
    {
        
    }
}
