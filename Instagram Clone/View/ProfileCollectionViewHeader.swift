//
//  ProfileCollectionViewHeader.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/25.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

protocol ProfileCollectionViewHeaderDelegate: AnyObject
{
    func HandleeditFollow(profileheader: ProfileCollectionViewHeader)
}

class ProfileCollectionViewHeader: UICollectionViewCell
{
    
    
    weak var delegate: ProfileCollectionViewHeaderDelegate?
    
    
    var configurationset: configurationEditbutton?
    {
        didSet
        {
            configureeditbutton()
        }
    }
    
    var currentUser: User?
    {
        didSet
        {
            print("DEBUG: USER WSS SET")
            configurationUser()
            
        }
    }
    
    private let profileImageView : UIImageView =
    {
        let profileimage = UIImageView()
        profileimage.translatesAutoresizingMaskIntoConstraints = false
        profileimage.contentMode = .scaleAspectFill
        profileimage.clipsToBounds = true
        profileimage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        profileimage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        profileimage.layer.cornerRadius = 80 / 2
        
        return profileimage
    }()
    
    private let nameLabel : UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let postLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        
        let attributed = NSAttributedString(string: "Post", attributes: [.font: UIFont.systemFont(ofSize: 14),.foregroundColor:UIColor.lightGray])
        let MutabelAtributted = NSMutableAttributedString(string: "3 \n", attributes: [.font:  UIFont.boldSystemFont(ofSize: 16),.foregroundColor:UIColor.darkGray])
        MutabelAtributted.append(attributed)
        label.attributedText = MutabelAtributted
        
        return label
    }()
    
    private let FollowingLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        
        let attributed = NSAttributedString(string: "Following", attributes: [.font: UIFont.boldSystemFont(ofSize: 14),.foregroundColor:UIColor.lightGray])
        let MutabelAtributted = NSMutableAttributedString(string: "7 \n", attributes: [.font: UIFont.boldSystemFont(ofSize: 16),.foregroundColor:UIColor.darkGray])
        MutabelAtributted.append(attributed)
        label.attributedText = MutabelAtributted
        return label
    }()
    
    
    var FollowerLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        
        let attributed = NSAttributedString(string: "Followers", attributes: [.font: UIFont.systemFont(ofSize: 14),.foregroundColor:UIColor.lightGray])
        let MutabelAtributted = NSMutableAttributedString(string: "5 \n", attributes: [.font: UIFont.boldSystemFont(ofSize: 16),.foregroundColor:UIColor.darkGray])
        MutabelAtributted.append(attributed)
        label.attributedText = MutabelAtributted
        return label
    }()
    
    var editFollowButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Edit Profile", for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        
        
        button.addTarget(self, action: #selector(HandleIeditprofile), for: .primaryActionTriggered)
        
        return button
    }()
    
    
    private let gridbutton: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "grid"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(HandleGrid), for: .primaryActionTriggered)
        
        return button
    }()
    
    private let ListButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(HandleList), for: .primaryActionTriggered)
        
        return button
    }()
    
    private let BookMark: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(HandleBookMark), for: .primaryActionTriggered)
        
        return button
    }()
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        configured()
        createHeaderfooterwview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ProfileCollectionViewHeader
{
    private func style()
    {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.profileImageView.backgroundColor = .darkGray
        self.addSubview(profileImageView)
        self.addSubview(nameLabel)
        
    }
    
    private func layout()
    {
        let stack = UIStackView(arrangedSubviews: [postLabel,FollowingLabel,FollowerLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        
        self.addSubview(stack)
        
        self.addSubview(editFollowButton)
        
        NSLayoutConstraint.activate([profileImageView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 3),
                                     profileImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: profileImageView.bottomAnchor, multiplier: 1),
                                     nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
                                     
        ])
        
        NSLayoutConstraint.activate([stack.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 4),
                                     stack.leadingAnchor.constraint(equalToSystemSpacingAfter: profileImageView.trailingAnchor, multiplier: 2),
                                     self.trailingAnchor.constraint(equalToSystemSpacingAfter: stack.trailingAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([editFollowButton.topAnchor.constraint(equalToSystemSpacingBelow: stack.bottomAnchor, multiplier: 2),
                                     editFollowButton.widthAnchor.constraint(equalToConstant: 280),
                                     self.trailingAnchor.constraint(equalToSystemSpacingAfter: editFollowButton.trailingAnchor, multiplier: 1)
        ])
    }
    
    private func configured()
    {
        
    }
}
//=================== Bottom view header section
extension ProfileCollectionViewHeader
{
    func createHeaderfooterwview()
    {
        let topview: UIView =
        {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
            view.backgroundColor = .lightGray
            return view
        }()
        
        let bottomView: UIView =
        {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
            view.backgroundColor = .lightGray
            return view
        }()
        
        let stackview = UIStackView(arrangedSubviews: [gridbutton,ListButton,BookMark])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.spacing = 10
        self.addSubview(topview)
        self.addSubview(bottomView)
        self.addSubview(stackview)
        
        NSLayoutConstraint.activate([stackview.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 0),
                                     self.bottomAnchor.constraint(equalToSystemSpacingBelow: stackview.bottomAnchor, multiplier: 1),
                                     self.trailingAnchor.constraint(equalToSystemSpacingAfter: stackview.trailingAnchor, multiplier: 0)
        ])
        
        NSLayoutConstraint.activate([topview.topAnchor.constraint(equalTo: stackview.topAnchor, constant: 0),
                                     topview.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 0),
                                     self.trailingAnchor.constraint(equalToSystemSpacingAfter: topview.trailingAnchor, multiplier: 0)
        ])
        
        NSLayoutConstraint.activate([bottomView.bottomAnchor.constraint(equalTo: stackview.bottomAnchor),
                                     bottomView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 0),
                                     self.trailingAnchor.constraint(equalToSystemSpacingAfter: bottomView.trailingAnchor, multiplier: 0)
        ])
        
    }
}
//==============================================================
extension ProfileCollectionViewHeader
{
    @objc func HandleIeditprofile()
    {
        delegate?.HandleeditFollow(profileheader: self)
    }
    
    @objc func HandleGrid()
    {
        print("DEBUG: GRID")
    }
    
    @objc func HandleList()
    {
        print("DEBUG: LIST")
    }
    
    @objc func HandleBookMark()
    {
        print("DEBUG: BOOKMARK")
    }
    
    
    func configurationUser()
    {
        guard let currentuser = currentUser else {return}
        self.nameLabel.text = "\(currentuser.username  ?? "Erick Elnino")"
        profileImageView.loadImage(with: currentuser.profileImage)
    }
    
    
    
    func configureeditbutton()
    {
        guard let currentuserid = Auth.auth().currentUser?.uid else {return}
        guard let userselected = currentUser else {return}
        guard let buttonsetting = configurationset else {return}
        
        if currentuserid == userselected.userID && buttonsetting == .editprofile
        {

            self.editFollowButton.setTitle( buttonsetting.description, for: .normal)
        
        }else if currentuserid != userselected.userID && buttonsetting == .followuser
        {
            self.editFollowButton.setTitle( buttonsetting.description, for: .normal)
            self.editFollowButton.setTitleColor(.white, for: .normal)
            self.editFollowButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
        }
        
    }
    
    
}
