//
//  FeedController.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/24.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit
import Firebase

typealias AlertFunction = (UIAlertAction) -> Void

private let collectionViewID = "CollectionViewID"

class FeedController: UICollectionViewController
{
    
    private var Allpost = [Post]()
    
    var viewSinglePost: Bool = false
    
    var myPost: Post?
    
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        UpdateUserFeed()
        fetchAllpost()
    }
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        UpdateUserFeed()
        Controllerlayout()
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionViewID)
        navigationItem.title = "Feed"
        style(viewpostsignle: viewSinglePost)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension FeedController: UICollectionViewDelegateFlowLayout
{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewSinglePost ? 1 : Allpost.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.FeedCellId, for: indexPath) as? FeedCell else {return UICollectionViewCell()}
        cell.delegate = self
        cell.selectedPost = viewSinglePost ? myPost! : Allpost[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let height = width + 200
        return CGSize(width: width, height: height)
    }
    
}
extension FeedController
{
    func style(viewpostsignle: Bool)
    {
        if viewpostsignle != true
        {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handlelogOut))
            self.navigationController?.navigationBar.tintColor = .black
        }
        
        
        self.collectionView.backgroundColor = .white
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "send2")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(handleSendMessage))
        
        self.collectionView.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.FeedCellId)
        
    }
    
    @objc func handleSendMessage()
    {
        print("DEBUG: Send Message")
    }
    
    private func Controllerlayout()
    {
        
    }
    
    @objc func handlelogOut()
    {
        self.alertMessage(Message: "Are you sure you want to Logout ?", title: "Logout") { (alertAction) in
            do
            {
                try Auth.auth().signOut()
                let loginVC = LoginViewController()
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true, completion: nil)
            }catch
            {
                print("DEBUG: Errpr Found :")
            }
        }
    }
    
    
}

extension FeedController
{
    private func UpdateUserFeed()
    {
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        
        Database.database().reference().child("User-following").child(currentUserID).observe(.childAdded) { datasnapshots in
            let userfollowingID = datasnapshots.key
            Database.database().reference().child("User-posts").child(userfollowingID).observe(.childAdded) { userfollowingPost in
                let postID = userfollowingPost.key
                print("DEBUG:USER FOLLOWING ID: \(userfollowingID) POSTID:  \(postID)")
                Database.database().reference().child("User-Feeds").child(currentUserID).updateChildValues([postID:1])
            }
        }
        
        Database.database().reference().child("User-posts").child(currentUserID).observe(.childAdded) { currentuserpost in
            let postID = currentuserpost.key
            print("DEBUG: CURRENT USER ID : \(currentUserID) POSTID: \(postID)")
            Database.database().reference().child("User-Feeds").child(currentUserID).updateChildValues([postID:1])
        }
    }
    
    private func fetchAllpost()
    {
        Services.shared.fetchAllpost { posts in
            self.Allpost.append(posts)
            self.collectionView.reloadData()
        }
    }
}

extension FeedController: FeedCellDelegate
{
    func usernameButtonTapped(cell: FeedCell, buttonPressed: UIButton) {
        
        guard let currentID = Auth.auth().currentUser?.uid else {return}
        if cell.usernameButton == buttonPressed
        {
            guard let posts = cell.selectedPost else {return}
            guard let postUser = posts.user else {return}
            
            if posts.user?.userID != currentID
            {
                let controller = ProfileController(collectionViewLayout: UICollectionViewFlowLayout(), config: .followuser)
                controller.userfromsearchVC = postUser
                controller.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(controller, animated: true)
            }else
            {
                let controller = ProfileController(collectionViewLayout: UICollectionViewFlowLayout(), config:  .editprofile)
                
                controller.user = postUser
                controller.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
    func feedCellOptionButtonTapped(cell: FeedCell, buttonPressed: UIButton) {
        if cell.FeedCellOption == buttonPressed
        {
            print("DEBUG: OPTION")
        }
    }
    
    func FeedLikeButtonTapped(cell: FeedCell, buttonPressed: UIButton) {
        if cell.LikeButton == buttonPressed
        {
            print("DEBUG: LIKE")
        }
    }
    
    func FeedCommentbuttonTapped(cell: FeedCell, buttonPressed: UIButton) {
        if cell.CommentButton == buttonPressed
        {
            print("DEBUG: COMMENT")
        }
    }
    
    func FeedMessageButtonTapped(cell: FeedCell, buttonPressed: UIButton) {
        if cell.MessageButton == buttonPressed
        {
            print("DEBUG: MESSAGE")
        }
    }
    
    func BookmarkButtonTapped(cell: FeedCell, buttonPressed: UIButton) {
        if cell.savePostButton == buttonPressed
        {
            print("DEBUG: BOOKMARK")
        }
    }
    
    
}
