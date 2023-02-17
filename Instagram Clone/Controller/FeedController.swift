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
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        style()
        
    }
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        style()
        fetchAllpost()
        Controllerlayout()
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionViewID)
        navigationItem.title = "Feed"
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
        return Allpost.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.FeedCellId, for: indexPath) as? FeedCell else {return UICollectionViewCell()}
        cell.selectedPost = Allpost[indexPath.row]
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
    private func style()
    {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handlelogOut))
        self.navigationController?.navigationBar.tintColor = .black
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
    
    func alertMessage(Message: String, title: String, completion: @escaping(AlertFunction))
    {
        let alert = UIAlertController(title: title, message: Message, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Logout", style: .destructive, handler: completion)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alertAction) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

extension FeedController
{
    private func fetchAllpost()
    {
        Services.shared.fetchAllpost(userid: UserId.elninoID) { posts in
            self.Allpost.append(posts)
            
            self.Allpost.sort { (post1, post2) -> Bool in
                return post1.date > post2.date
            }
            self.collectionView.reloadData()
        }
      
    }
}
