//
//  LoginViewController.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/21.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{
    let emailtextfield: UITextField =
    {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Email"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .init(white: 0, alpha: 0.04)
        tf.font = UIFont.preferredFont(forTextStyle: .body)
        tf.textColor = .darkGray
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return tf
        
    }()
    
    
    let passwordTextfield : UITextField =
    {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .init(white: 0, alpha: 0.04)
        tf.font = UIFont.preferredFont(forTextStyle: .body)
        tf.textColor = .darkGray
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return tf
        
    }()
    
    
    private let loginBUtton: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        buttonActions()
    }
}

extension LoginViewController
{
    private func style()
    {
        view.backgroundColor = .white
    }
    
    private func layout()
    {
        let stackController = UIStackView(arrangedSubviews: [emailtextfield,passwordTextfield,loginBUtton])
        stackController.translatesAutoresizingMaskIntoConstraints = false
        stackController.axis = .vertical
        stackController.distribution = .fillEqually
        stackController.spacing = 10
        
        view.addSubview(stackController)
        
        
        NSLayoutConstraint.activate([stackController.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 10),
                                     stackController.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
                                     view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackController.trailingAnchor, multiplier: 4),
                                     
        ])
    }
}

extension LoginViewController
{
    func buttonActions()
    {
        loginBUtton.addTarget(self, action: #selector(HandleloginAction), for: .primaryActionTriggered)
    }
    
    @objc func HandleloginAction()
    {
        print("DEBUG: LOGIN !!!")
    }
}
