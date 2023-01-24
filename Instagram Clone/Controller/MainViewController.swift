//
//  MainViewController.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/24.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
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
    
    
    private func viewcontrollers()
    {
        
        let feedController = buildnavigationController(selectedImage: UIImage(named: ""), rootViewController: FeedController())
        
        let searchfeedController = buildnavigationController(selectedImage: UIImage(named: ""), rootViewController: SearchFeedController())
        
        let postcontroller = buildnavigationController(selectedImage: UIImage(named: ""), rootViewController: PostController())
        
        let notificationController = buildnavigationController(selectedImage: UIImage(named: ""), rootViewController: NotificationController())
        
        let profilecontroller = buildnavigationController(selectedImage: UIImage(named: ""), rootViewController: ProfileController())
        
        
        self.viewControllers = [feedController,searchfeedController,postcontroller,notificationController,profilecontroller]
        
    }
    
    
    private func buildnavigationController(selectedImage: UIImage?, rootViewController: UIViewController) -> UINavigationController
    {
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.tabBarItem.image = selectedImage
        navigation.navigationBar.barTintColor = .black
        return navigation
    }
}
