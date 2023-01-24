//
//  SignUpViewController.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/22.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    private lazy var PlusPhotoButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus_photo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.heightAnchor.constraint(equalToConstant: 150).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.layer.cornerRadius = 150 / 2
        
        return button
    }()
    
    let Emailtextfield: UITextField =
    {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Email"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .init(white: 0, alpha: 0.04)
        tf.font = UIFont.preferredFont(forTextStyle: .body)
        tf.textColor = .darkGray
        tf.addTarget(self, action: #selector(Handlevalidation), for: .editingChanged)
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return tf
        
    }()
    
    
    let Usernametextfield : UITextField =
    {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Username"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .init(white: 0, alpha: 0.04)
        tf.font = UIFont.preferredFont(forTextStyle: .body)
        tf.textColor = .darkGray
         tf.addTarget(self, action: #selector(Handlevalidation), for: .editingChanged)
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return tf
        
    }()
    
    let FullnameTextfield : UITextField =
    {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Fullname"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .init(white: 0, alpha: 0.04)
        tf.font = UIFont.preferredFont(forTextStyle: .body)
        tf.textColor = .darkGray
         tf.addTarget(self, action: #selector(Handlevalidation), for: .editingChanged)
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return tf
        
    }()
    
    
    let Passwordtetxfield : UITextField =
    {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .init(white: 0, alpha: 0.04)
        tf.font = UIFont.preferredFont(forTextStyle: .body)
        tf.textColor = .darkGray
        tf.isSecureTextEntry = true
         tf.addTarget(self, action: #selector(Handlevalidation), for: .editingChanged)
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return tf
        
    }()
    
    private let signUpButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign up", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    
    private var AlreadyHaveanAccountButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let attributted = NSAttributedString(string: "Log In", attributes: [.font: UIFont.boldSystemFont(ofSize: 14),.foregroundColor: UIColor(red: 0/255, green: 120/255, blue: 175/255, alpha: 1)])
        let MuttableAttributed = NSMutableAttributedString(string: "You already have an account?", attributes: [.font:UIFont.preferredFont(forTextStyle: .caption1), .foregroundColor: UIColor.darkGray])
        MuttableAttributed.append(attributted)
        button.setAttributedTitle(MuttableAttributed, for: .normal)
        
        return button
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        hideNavigationController()
        buttonPressedAction()
    }
    
    func hideNavigationController()
    {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
}

extension SignUpViewController
{
    private func style()
    {
        view.backgroundColor = .white
        view.addSubview(PlusPhotoButton)
        view.addSubview(AlreadyHaveanAccountButton)
        
    }
    
    
    private func layout()
    {
        let stack = UIStackView(arrangedSubviews: [Emailtextfield,Usernametextfield,FullnameTextfield,Passwordtetxfield,signUpButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        stack.axis = .vertical
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([PlusPhotoButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
                                     PlusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([stack.topAnchor.constraint(equalToSystemSpacingBelow: PlusPhotoButton.bottomAnchor, multiplier: 4),
                                     stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     stack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
                                     view.trailingAnchor.constraint(equalToSystemSpacingAfter: stack.trailingAnchor, multiplier: 4)
        ])
        
        
        NSLayoutConstraint.activate([view.bottomAnchor.constraint(equalToSystemSpacingBelow: AlreadyHaveanAccountButton.bottomAnchor, multiplier: 2),
                                     AlreadyHaveanAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
}

extension SignUpViewController
{
    func buttonPressedAction()
    {
        PlusPhotoButton.addTarget(self, action: #selector(HandlePhotoPlusAction), for: .primaryActionTriggered)
        signUpButton.addTarget(self, action: #selector(HandlesignUpButtonPressed), for: .primaryActionTriggered)
        AlreadyHaveanAccountButton.addTarget(self,action: #selector(HandleLoginAccountPressed), for: .primaryActionTriggered)
        signUpButton.isEnabled = false
        
    }
    
    @objc func HandlePhotoPlusAction()
    {
        let controller = UIImagePickerController()
        
        controller.delegate = self
        controller.modalPresentationStyle = .fullScreen
        controller.allowsEditing = true
        self.present(controller, animated: true, completion: nil)
    }
    
    @objc func HandlesignUpButtonPressed()
    {
        guard let email = Emailtextfield.text else {return}
        guard let password = Passwordtetxfield.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (Results, Error) in
            guard Error == nil else
            { print("DEBUG: There was an Error \(Error!.localizedDescription)")
                return
            }
            
            print("DEBUG: User was successfully saved in the Database")
        }
    }
    
    @objc func HandleLoginAccountPressed()
    {
        _ = navigationController?.popToRootViewController(animated: true)
        
    }
    
    @objc func Handlevalidation(textfield: UITextField)
    {
        guard Emailtextfield.hasText,Usernametextfield.hasText,FullnameTextfield.hasText,Passwordtetxfield.hasText
        else
        {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = signUpButton.isEnabled ? UIColor(red: 0/255, green: 120/255, blue: 175/255, alpha: 1) : UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
            return
        }
        
        signUpButton.isEnabled = true
        signUpButton.backgroundColor = signUpButton.isEnabled ? UIColor(red: 0/255, green: 120/255, blue: 175/255, alpha: 1) : UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
    }
    
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imageSelected = info[.originalImage] as? UIImage else {return}
        print("DEBUG: Picture selected : \(imageSelected)")
    }
}
