//
//  PostController.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/24.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit


class PostController: UIViewController
{
    
    lazy var profilepicture: UIImageView =
    {
        let propic = UIImageView()
        propic.translatesAutoresizingMaskIntoConstraints = false
        propic.clipsToBounds =  true
        propic.layer.masksToBounds = true
        propic.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([propic.heightAnchor.constraint(equalToConstant: 90),
                                     propic.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        propic.layer.cornerRadius = 90 / 2
        
        
        return propic
    }()
    
    
    lazy var myTextfield: UITextField =
    {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderStyle = .roundedRect
        textfield.backgroundColor = .init(white: 0, alpha: 0.04)
        textfield.font = UIFont.preferredFont(forTextStyle: .body)
        textfield.textColor = .darkGray
        textfield.heightAnchor.constraint(equalToConstant: 90).isActive = true
        textfield.widthAnchor.constraint(equalToConstant: view.frame.width - 100).isActive = true
        
        return textfield
    }()
    
    
    lazy var shareButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Share", for: [])
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        button.widthAnchor.constraint(equalToConstant: 250).isActive = true
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    var user: User?
    var myImage: UIImage?
    {
        didSet
        {
            configureImage()
        }
    }
    
    init(user: User, myImage: UIImage) {
        self.user = user
        self.myImage = myImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        configure()
    }
}

extension PostController
{
    private func style()
    {
        view.backgroundColor = .white
        view.addSubview(profilepicture)
//        view.addSubview(myTextfield)
//        view.addSubview(shareButton)
        
        
    }
    private func configure()
    {
        NSLayoutConstraint.activate([profilepicture.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
                                     profilepicture.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1)
        ])
    }
    
    private func configureImage()
    {
       
    }
}



