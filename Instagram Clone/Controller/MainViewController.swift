//
//  MainViewController.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/24.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UITabBarController
{
    
    var currentUser: UserModel?
    {
        didSet
        {
            guard let current = currentUser else {return}
            guard let cholocontroller  = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {return}
            guard let profile  = cholocontroller.rootViewController as? ProfileController else {return}
            profile.user = current
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCurrentUserData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        checkUserifloggedIn()
    }
}

extension MainViewController: UITabBarControllerDelegate
{
    private func style()
    {
        self.delegate = self
        
    }
    
    
    private func layout()
    {
        viewcontrollers()
    }
    
    
    func viewcontrollers()
    {
        fetchCurrentUserData()

        let feedController = buildnavigationController(selectedImage: UIImage(named: "home_selected"), unselctedImage: UIImage(named: "home_unselected"), rootViewController: FeedController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        let searchfeedController = buildnavigationController(selectedImage: UIImage(named:"search_selected"), unselctedImage: UIImage(named:"search_unselected"), rootViewController: SearchFeedController())
        
        let postcontroller = buildnavigationController(selectedImage: UIImage(named: "plus_unselected"), unselctedImage: UIImage(named: "plus_unselected"), rootViewController: PostController())
        
        let notificationController = buildnavigationController(selectedImage: UIImage(named: "like_selected"), unselctedImage: UIImage(named: "like_unselected"), rootViewController: NotificationController())
        
        let profilecontroller = buildnavigationController(selectedImage: UIImage(named: "profile_selected"), unselctedImage: UIImage(named: "profile_unselected"), rootViewController: ProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        self.viewControllers = [feedController,searchfeedController,postcontroller,notificationController,profilecontroller]
        self.tabBar.tintColor = .black
    }
    
    
    private func buildnavigationController(selectedImage: UIImage?,unselctedImage: UIImage? , rootViewController: UIViewController) -> UINavigationController
    {
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.tabBarItem.image = unselctedImage
        navigation.tabBarItem.selectedImage = selectedImage
        navigation.navigationBar.barTintColor = .white
        return navigation
    }
}
extension MainViewController
{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let index = viewControllers?.firstIndex(of: viewController)
        {
            print("DEBUG: Index : \(index)")
        }
    }
}

extension MainViewController
{
    func checkUserifloggedIn()
    {
        if Auth.auth().currentUser?.uid == nil
        {
            DispatchQueue.main.async {
                let controller = UINavigationController(rootViewController: LoginViewController())
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
}
// API CALLS
extension MainViewController
{
    
    func fetchCurrentUserData()
    {
        guard let userid = Auth.auth().currentUser?.uid else {return}
        Services.shared.fetchUser(user_Id: userid) { user in
            self.currentUser = user
        }
    }
    
}
