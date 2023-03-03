//
//  CommentCell.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/03/01.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell
{
    static let commentCellID = "CommentCellIdentifier"
    
    
    var CommentSlected: Comment?
    {
        didSet
        {
            configureComment()
        }
    }
    
    lazy var profileImageView : CustomImageView =
        {
            let profileimage = CustomImageView()
            profileimage.translatesAutoresizingMaskIntoConstraints = false
            profileimage.contentMode = .scaleAspectFill
            profileimage.clipsToBounds = true
            profileimage.heightAnchor.constraint(equalToConstant: 60).isActive = true
            profileimage.widthAnchor.constraint(equalToConstant: 60).isActive = true
            profileimage.layer.cornerRadius = 60 / 2
            profileimage.backgroundColor = .lightGray
            
            return profileimage
    }()
    
    
    lazy var commentLabel: UILabel =
    {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()

    
    lazy var postButton: UIButton =
        {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.setTitle("Post", for: .normal)
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            button.widthAnchor.constraint(equalToConstant: 70).isActive = true
            
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            
            return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        configureComment()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommentCell
{
    private func style()
    {
       
        self.addSubview(profileImageView)
        self.addSubview(commentLabel)
        
        NSLayoutConstraint.activate([profileImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),
                                     profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([commentLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: profileImageView.trailingAnchor, multiplier: 2),
                                     commentLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        ])

    }
    
    
    private func layout()
    {
        
    }
    
    
     func configureComment()
    {
        guard let comment = CommentSlected else {return}
//        guard let user = comment.user else {return}
//        guard let imageUrl = user.profileImage else {return}
        
        let attributed = NSAttributedString(string: "\(comment.commentText ?? "")", attributes: [.font: UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor.darkGray])
         let attributed1 = NSAttributedString(string: " 2d", attributes: [.font: UIFont.systemFont(ofSize: 14),.foregroundColor:UIColor.lightGray])
        let MutabelAtributted = NSMutableAttributedString(string: "Eriik Elnino  ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14),.foregroundColor:UIColor.black])
        MutabelAtributted.append(attributed)
        MutabelAtributted.append(attributed1)
        self.commentLabel.attributedText = MutabelAtributted
//        self.profileImageView.loadImage(with: imageUrl)
    }
}
