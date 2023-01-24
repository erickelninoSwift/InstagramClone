//
//  LoginViewController.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/21.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController
{
    
    lazy var headerView: UIView =
        {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 150).isActive = true
            view.backgroundColor = UIColor(red: 0/255, green: 120/255, blue: 175/255, alpha: 1)
            
            var imageLogoView = UIImageView(image: UIImage(named: "Instagram_logo_white")?.withRenderingMode(.alwaysOriginal))
            imageLogoView.translatesAutoresizingMaskIntoConstraints = false
            imageLogoView.contentMode = .scaleAspectFill
            
            
            view.addSubview(imageLogoView)
            
            NSLayoutConstraint.activate([imageLogoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                         imageLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                         imageLogoView.heightAnchor.constraint(equalToConstant: 50),
                                         imageLogoView.widthAnchor.constraint(equalToConstant: 200)
            ])
            
            
            return view
    }()
    
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
        tf.addTarget(self, action: #selector(HandleValidation), for: .editingChanged)
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
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(HandleValidation), for: .editingChanged)
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return tf
        
    }()
    
    private var messageLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .systemRed
        label.textAlignment = .center
        label.text = "Email address/ Password failed!"
        label.numberOfLines = 0
        label.alpha = 0
        return label
    }()
    
    
    private let loginBUtton: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    
    private var dontHaveAccountButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let attributted = NSAttributedString(string: "Sign Up", attributes: [.font: UIFont.boldSystemFont(ofSize: 14),.foregroundColor: UIColor(red: 0/255, green: 120/255, blue: 175/255, alpha: 1)])
        let MuttableAttributed = NSMutableAttributedString(string: "Don't have an account ?", attributes: [.font:UIFont.preferredFont(forTextStyle: .caption1), .foregroundColor: UIColor.darkGray])
        MuttableAttributed.append(attributted)
        button.setAttributedTitle(MuttableAttributed, for: .normal)
        
        return button
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        buttonActions()
        navigationcontroller()
    }
    
    
    func navigationcontroller()
    {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
}

extension LoginViewController
{
    private func style()
    {
        view.backgroundColor = .white
        //        view.addSubview(messageLabel)
    }
    
    private func layout()
    {
        let stackController = UIStackView(arrangedSubviews: [emailtextfield,passwordTextfield,loginBUtton,messageLabel])
        stackController.translatesAutoresizingMaskIntoConstraints = false
        stackController.axis = .vertical
        stackController.distribution = .fillEqually
        stackController.spacing = 10
        
        view.addSubview(headerView)
        view.addSubview(stackController)
        view.addSubview(dontHaveAccountButton)
        
        NSLayoutConstraint.activate([headerView.topAnchor.constraint(equalTo: view.topAnchor),
                                     headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        
        
        NSLayoutConstraint.activate([stackController.topAnchor.constraint(equalToSystemSpacingBelow: headerView.bottomAnchor, multiplier: 5),
                                     stackController.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
                                     view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackController.trailingAnchor, multiplier: 4),
                                     
        ])
        
        
        NSLayoutConstraint.activate([view.bottomAnchor.constraint(equalToSystemSpacingBelow: dontHaveAccountButton.bottomAnchor, multiplier: 2),
                                     dontHaveAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension LoginViewController
{
    func buttonActions()
    {
        loginBUtton.addTarget(self, action: #selector(HandleloginAction), for: .primaryActionTriggered)
        loginBUtton.isEnabled = false
        dontHaveAccountButton.addTarget(self, action: #selector(HandleSignupButtonAction), for: .primaryActionTriggered)
    }
    
    @objc func HandleloginAction()
    {
        guard let username = emailtextfield.text else {return}
        guard let password = passwordTextfield.text else {return}
        
        Auth.auth().signIn(withEmail: username, password: password) { (Dataresult, Error) in
            if let error = Error
            {
                self.messageLabel.alpha = 1
                self.messageLabel.text = "\(error.localizedDescription)"
                return
            }
            
            self.messageLabel.alpha = 0
            print("DEBUG: User is logged In !!!")
            
        }
        
    }
    
    @objc func HandleSignupButtonAction()
    {
        let controller = SignUpViewController()
        controller.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension LoginViewController
{
    @objc func HandleValidation()
    {
        guard emailtextfield.hasText,
            passwordTextfield.hasText else{
                validation(buttonisEnable: false)
                return
        }
        validation(buttonisEnable: true)
    }
    
    
    func validation(buttonisEnable: Bool)
    {
        loginBUtton.isEnabled = buttonisEnable
        if buttonisEnable
        {
            loginBUtton.backgroundColor = loginBUtton.isEnabled ? UIColor(red: 0/255, green: 120/255, blue: 175/255, alpha: 1) : UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        }else
        {
            loginBUtton.backgroundColor = loginBUtton.isEnabled ? UIColor(red: 0/255, green: 120/255, blue: 175/255, alpha: 1) : UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        }
    }
}

