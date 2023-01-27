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
    
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        style()

    }
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        style()
        Controllerlayout()
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionViewID)
        navigationItem.title = "Feed"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension FeedController
{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewID, for: indexPath)
        return cell
    }
    
}
extension FeedController
{
    private func style()
    {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handlelogOut))
        self.navigationController?.navigationBar.tintColor = .black
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
