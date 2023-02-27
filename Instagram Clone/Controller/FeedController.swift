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
        controllerRefresh()
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
    
    
    func controllerRefresh()
    {
        let refechcontroller = UIRefreshControl()
        refechcontroller.addTarget(self, action: #selector(HandleRefresher), for: .primaryActionTriggered)
        
        self.collectionView.refreshControl = refechcontroller
        
    }
    
    @objc func HandleRefresher()
    {
        self.Allpost.removeAll(keepingCapacity: false)
        self.fetchAllpost()
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
                loginVC.modalTransitionStyle = .crossDissolve
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
                
                Database.database().reference().child("User-Feeds").child(currentUserID).updateChildValues([postID:1])
            }
        }
        
        Database.database().reference().child("User-posts").child(currentUserID).observe(.childAdded) { currentuserpost in
            let postID = currentuserpost.key
            
            Database.database().reference().child("User-Feeds").child(currentUserID).updateChildValues([postID:1])
        }
    }
    
    private func fetchAllpost()
    {
        self.collectionView.refreshControl?.beginRefreshing()
        Services.shared.fetchAllpost { posts in
            self.Allpost.append(posts)
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }
}

extension FeedController: FeedCellDelegate
{
    func postImageTapped(with cell: FeedCell, post: Post) {
        guard let myPost = cell.selectedPost else {return}
       
        if myPost.didlike
        {
            myPost.adjustlike(addlike: false) { likes in
                cell.likesLabel.text = "\(likes) Likes"
                cell.LikeButton.setImage(UIImage(named: "like_unselected")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
            }
        }else
        {
            myPost.adjustlike(addlike: true) { likes in
                cell.likesLabel.text = "\(likes) Likes"
                cell.LikeButton.setImage(UIImage(named: "like_selected")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), for: .normal)
            }
        }
        
    }
    
//    =====================
    func likeLabelTapped(cell: FeedCell, likedPost: String) {
        print("DEBUG: POST LIKED TAPPED : \(likedPost)")
    }
//    ======================
    
    
    func configureLikebutton(with cell: FeedCell, likebutton: UIButton) {
        
        guard let post = cell.selectedPost else {return}
        guard let currentuserId = Auth.auth().currentUser?.uid else {return}
        guard let postSelected = post.post_ID else {return}
        
        Database.database().reference().child("User-Likes").child(currentuserId).child(postSelected).observeSingleEvent(of: .value) { datasnapshotDatapost in
            if datasnapshotDatapost.exists()
            {
                cell.selectedPost?.didlike = true
                cell.LikeButton.setImage(UIImage(named: "like_selected")?.withTintColor( .systemRed, renderingMode: .alwaysOriginal), for: .normal)
            }
        }
    }
    
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
            guard let post = cell.selectedPost else {return}
//            guard let postId = post.post_ID else {return}
//            guard let currentuser = Auth.auth().currentUser?.uid else {return}
            
            if post.didlike
            {
                post.adjustlike(addlike: false) { likes in
                    cell.likesLabel.text = "\(likes) Likes"
                    cell.LikeButton.setImage(UIImage(named: "like_unselected")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
                }
//                Database.database().reference().child("Post-likes").child(postId).child(currentuser).removeValue()
//                Database.database().reference().child("User-Likes").child(currentuser).child(postId).removeValue()
              
               
            }else
            {
                post.adjustlike(addlike: true) { likes in
                      cell.likesLabel.text = "\(likes) Likes"
                     cell.LikeButton.setImage(UIImage(named: "like_selected")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), for: .normal)
                }
                
//                let datavalue = [postId:1] as [String:Any]
//                Database.database().reference().child("User-Likes").child(currentuser).updateChildValues(datavalue)
//                Database.database().reference().child("Post-likes").child(postId).updateChildValues([currentuser:1])
              
              
            }
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

