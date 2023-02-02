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

class ProfileCollectionViewHeader: UICollectionViewCell
{
    
    
    weak var delegate: ProfileCollectionViewHeaderDelegate?
    
    weak var labelActionDelegate: profileheaderLabelActionDelegate?
    
    
    var userfollowing: Bool = false
    
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
            checkifuserfollwing()
            configurationUser()
        }
    }
    
    lazy var profileImageView : UIImageView =
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
    
    lazy var nameLabel : UILabel =
        {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 14)
            
            return label
    }()
    
    lazy var postLabel: UILabel =
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
    
    lazy var FollowingLabel: UILabel =
        {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.textAlignment = .center
            
            let attributed = NSAttributedString(string: "Following", attributes: [.font: UIFont.boldSystemFont(ofSize: 14),.foregroundColor:UIColor.lightGray])
            let MutabelAtributted = NSMutableAttributedString(string: "0 \n", attributes: [.font: UIFont.boldSystemFont(ofSize: 16),.foregroundColor:UIColor.darkGray])
            MutabelAtributted.append(attributed)
            label.attributedText = MutabelAtributted
            
            return label
    }()
    
    
    lazy var FollowerLabel: UILabel =
        {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.textAlignment = .center
            
            let attributed = NSAttributedString(string: "Followers", attributes: [.font: UIFont.systemFont(ofSize: 14),.foregroundColor:UIColor.lightGray])
            let MutabelAtributted = NSMutableAttributedString(string: "0 \n", attributes: [.font: UIFont.boldSystemFont(ofSize: 16),.foregroundColor:UIColor.darkGray])
            MutabelAtributted.append(attributed)
            label.attributedText = MutabelAtributted
            
            return label
    }()
    
    lazy var editFollowButton: UIButton =
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
            
            return button
    }()
    
    
    let gridbutton: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "grid"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(HandleGrid), for: .touchUpInside)
        
        return button
    }()
    
    private let ListButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(HandleList), for: .touchUpInside)
        
        return button
    }()
    
    private let BookMark: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(HandleBookMark), for: .touchUpInside)
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        myUIGesture()
        configured()
        style()
        layout()
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
        self.editFollowButton.addTarget(self, action: #selector(HandleIeditprofile), for: .primaryActionTriggered)
        
        
    }
    
    private func myUIGesture()
    {
        let followTapgesture = UITapGestureRecognizer(target: self, action: #selector(FollowlabelAction))
        self.FollowerLabel.addGestureRecognizer(followTapgesture)
        self.FollowerLabel.isUserInteractionEnabled = true
        
        let followingTapgesture = UITapGestureRecognizer(target: self, action: #selector(HandleFollowingAction))
        self.FollowingLabel.addGestureRecognizer(followingTapgesture)
        self.FollowingLabel.isUserInteractionEnabled = true
        
        
        let posttapGesture = UITapGestureRecognizer(target: self, action: #selector(HandlePostTappedAction))
        self.postLabel.addGestureRecognizer(posttapGesture)
        self.postLabel.isUserInteractionEnabled = true
        
    }
    
    @objc func FollowlabelAction()
    {
        labelActionDelegate?.HandleFollowersLabel(userProfileHeader: self)
    }
    
    @objc func HandleFollowingAction()
    {
        labelActionDelegate?.HandleFollowingLabel(userProfileHeader: self)
    }
    
    @objc func HandlePostTappedAction()
    {
        labelActionDelegate?.HandlePostLabel(userProfileHeader: self)
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
        
        delegate?.HandleeditFollow(profileheader: self, buttonConfig: self.configurationset!)
    }
    
    @objc func HandleGrid()
    {
        delegate?.handleGrid(CurrentButton: self.gridbutton, profileheader: self)
    }
    
    @objc func HandleList()
    {
        delegate?.handleListController(CurrentButton: self.ListButton, profileheader: self)
        
    }
    
    @objc func HandleBookMark()
    {
        delegate?.handleListController(CurrentButton: self.BookMark, profileheader: self)
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
            if userselected.isFollowed == true
            {
                self.editFollowButton.setTitle("Following", for: .normal)
                self.editFollowButton.setTitleColor(.white, for: .normal)
                self.editFollowButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
                checkifuserfollwing()
            }else
            {
                checkifuserfollwing()
                self.editFollowButton.setTitle("Follow", for: .normal)
                self.editFollowButton.setTitleColor(.white, for: .normal)
                self.editFollowButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
                
            }
        }
        
    }
    
    func checkifuserfollwing()
    {
        guard let current = currentUser else {return}
        guard let myUID = Auth.auth().currentUser?.uid else {return}
        
        if current.userID != myUID
        {
            current.checkuserFollow(myUser: current, myuserID: myUID, completion: { isFollowed in
                current.isFollowed = isFollowed
            })
        }
    }
    
    
}
