//
//  CommentViewContorller.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/03/01.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit
import Firebase

private let collectionviewcellID = "CollectionViewID"

class CommentViewContorller: UICollectionViewController
{
    
    var selectedPost: Post?
    var AllComment = [Comment]()

    lazy var commentTetxfield: UITextField =
        {
            let textfield = UITextField()
            textfield.translatesAutoresizingMaskIntoConstraints = false
            textfield.borderStyle = .roundedRect
            textfield.placeholder = "Type in you comment here"
            textfield.textColor = .darkGray
            textfield.backgroundColor = .white
            
            return textfield
    }()
    
    lazy var postButton: UIButton =
        {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.setTitle("Post", for: .normal)
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            button.widthAnchor.constraint(equalToConstant: 80).isActive = true
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.layer.cornerRadius = 5
            
            button.backgroundColor = .darkGray
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(HandlepostButton), for: .primaryActionTriggered)
            
            return button
    }()
    
    
    lazy var containerView: UIView =
        {
            let container  = UIView()
            
            container.addSubview(commentTetxfield)
            container.addSubview(postButton)
            
            
            container.translatesAutoresizingMaskIntoConstraints = false
            container.backgroundColor = .white
            container.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
            
            
            NSLayoutConstraint.activate([commentTetxfield.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                                         commentTetxfield.leadingAnchor.constraint(equalToSystemSpacingAfter: container.leadingAnchor, multiplier: 1),
                                         //
            ])
            
            NSLayoutConstraint.activate([postButton.leadingAnchor.constraint(equalToSystemSpacingAfter:commentTetxfield.trailingAnchor , multiplier: 1),
                                         postButton.centerYAnchor.constraint(equalTo: commentTetxfield.centerYAnchor),
                                         container.trailingAnchor.constraint(equalToSystemSpacingAfter: postButton.trailingAnchor, multiplier: 1)
                
            ])
            
            
            let separatorView = UIView()
            separatorView.translatesAutoresizingMaskIntoConstraints = false
            
            separatorView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
            separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
            container.addSubview(separatorView)
            
            NSLayoutConstraint.activate([separatorView.leadingAnchor.constraint(equalToSystemSpacingAfter: container.leadingAnchor, multiplier: 0),
                                         container.trailingAnchor.constraint(equalToSystemSpacingAfter: separatorView.trailingAnchor, multiplier: 0),
                                         separatorView.topAnchor.constraint(equalTo: container.topAnchor)
            ])
            
            return container
    }()
    
    
    init(collectionViewLayout layout: UICollectionViewLayout , selectedPost: Post) {
        self.selectedPost = selectedPost
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        fetchAllcomment()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }
    
    override var inputAccessoryView: UIView?
    {
        return containerView
    }
    
    override var canBecomeFirstResponder: Bool
    {
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

extension CommentViewContorller: UICollectionViewDelegateFlowLayout
{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AllComment.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.commentCellID, for: indexPath) as? CommentCell else
        {return UICollectionViewCell()}
        cell.CommentSlected = AllComment[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 500)
//        let dummyCell = CommentCell(frame: frame)
//        dummyCell.CommentSlected = AllComment[indexPath.item]
//        dummyCell.layoutIfNeeded()
//
//        let targetSize = CGSize(width: view.frame.width, height: 1000)
//        let estimated = dummyCell.systemLayoutSizeFitting(targetSize)
//
//        let height = max(65, estimated.height)
        return CGSize(width: view.frame.width, height: 80)
    }
    
}

extension CommentViewContorller
{
    private func style()
    {
        self.collectionView.backgroundColor = .white
        self.collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.commentCellID)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.title = "Comments"
    }
    
    private func layout()
    {
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.keyboardDismissMode = .interactive
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        self.collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
    }
    
    
    @objc private func HandlepostButton()
    {
        guard let post = selectedPost else {return}
        guard let postId = post.post_ID else {return}
        guard let comment = commentTetxfield.text else {return}
        guard let currentuserid = Auth.auth().currentUser?.uid else {return}
        let currentDate = Int(NSDate().timeIntervalSince1970)
        
        let datavalue = ["Post-ID": postId,"Comment": comment,"Comment_User_id": currentuserid,"creationDate": currentDate] as [String:Any]
        self.postComment(postid: postId, valuedata: datavalue)
    }
    
    
    func postComment(postid: String , valuedata: [String:Any])
    {
        
        Database.database().reference().child("Post-Comments").child(postid).childByAutoId().updateChildValues(valuedata) { (Error, databaseref) in
            if let error  = Error
            {
                print("DEBUG: Error found while commenting on the post : \(error.localizedDescription)")
                return
            }
            self.commentTetxfield.text = ""
            print("DEBUG: COMMENT WAS SUCCESSFULLY ADDED")
            self.commentTetxfield.placeholder = "Type in you comment here"
            self.collectionView.reloadData()
           
        }
    }
    
    
    func fetchAllcomment()
    {
        guard let post = selectedPost else {return}
        guard let postId = post.post_ID else {return}
        
        Database.database().reference().child("Post-Comments").child(postId).observe(.childAdded) { datasnapshopt in
            guard datasnapshopt.exists() else
            { print("DEBUG: THERE WAS NO DATA")
                return}
            guard let currentcomment = datasnapshopt.value as? [String:Any] else {return}
            let myComments = Comment(datavalue: currentcomment)
            self.AllComment.append(myComments)
            self.collectionView.reloadData()
        }
    }
}

