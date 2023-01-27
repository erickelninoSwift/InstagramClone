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
    
    
    
    private var imageSelected: Bool = false
    
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
    
    private lazy var errorLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .systemRed
        label.textAlignment = .center
        label.text = "Error while saving data"
        label.numberOfLines = 0
        label.alpha = 0
        return label
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
        let stack = UIStackView(arrangedSubviews: [Emailtextfield,Usernametextfield,FullnameTextfield,Passwordtetxfield,signUpButton,errorLabel])
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
        guard let email = Emailtextfield.text?.lowercased() else {return}
        guard let password = Passwordtetxfield.text else {return}
        guard let fullname = FullnameTextfield.text?.lowercased() else {return}
        guard let userName = Usernametextfield.text?.lowercased() else {return }
        
        
        if imageSelected == true
        {
            Auth.auth().createUser(withEmail: email, password: password) { (Results, Error) in
                guard Error == nil else
                { print("DEBUG: There was an Error \(Error!.localizedDescription)")
                    self.errorLabel.alpha = 1
                    self.errorLabel.text = "\(Error!.localizedDescription)"
                    return
                }
                 self.errorLabel.alpha = 0
                guard let profileImage = self.PlusPhotoButton.imageView?.image else {return}
                guard let ImageData = profileImage.jpegData(compressionQuality: 0.3) else {return}
                
                let fileName = NSUUID().uuidString
                
                let Reference =  Storage.storage().reference().child("Profile_Image").child(fileName)
                
                 Reference.putData(ImageData) { metadata, Error in
                    if let error  = Error
                    {
                        self.errorLabel.alpha = 1
                        self.errorLabel.text = "\(error.localizedDescription)"
                        return
                    }
                     self.errorLabel.alpha = 0
                    guard let currentUserid = Auth.auth().currentUser?.uid else {return }
                    
                    Reference.downloadURL { (url, Error) in
                        
                        guard let profilepictureUrl = url?.absoluteString else {return}
                        let userdictionary = ["UserId":currentUserid,"Username": userName,"Fullname": fullname,"Email":email,"Password":password,"ProfileImageURL":profilepictureUrl] as [String:Any]
                        Database.database().reference().child("Users").child(currentUserid).updateChildValues(userdictionary) { (Error, Databaseref) in
                            if let error  =  Error
                            {
                                self.errorLabel.alpha = 1
                                self.errorLabel.text = "\(error.localizedDescription)"
                                return
                            }
                            
                            guard let controller = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {return}
                            guard let tab = controller.rootViewController as? MainViewController else {return}
                            
                            tab.checkUserifloggedIn()
                            tab.fetchCurrentUserData()
                            tab.viewcontrollers()
                            self.dismiss(animated: true, completion: nil)
                            self.errorLabel.alpha = 0
                        }
                    }
                
                }
                
                
                print("DEBUG: User was successfully saved in the Database")
            }
        }else
        {
            print("DEBUG: You need To select an Image for your profile picrture Before proceeding ")
        }
    }
    
    @objc func HandleLoginAccountPressed()
    {
        _ = navigationController?.popToRootViewController(animated: true)
        
    }
    
    @objc func Handlevalidation(textfield: UITextField)
    {
        guard Emailtextfield.hasText,Usernametextfield.hasText,FullnameTextfield.hasText,Passwordtetxfield.hasText,imageSelected == true
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
        guard let pcitureSelected = info[.editedImage] as? UIImage else
        {
            imageSelected = false
            return
            
        }
        
        imageSelected = true
        PlusPhotoButton.layer.borderColor = UIColor.white.cgColor
        PlusPhotoButton.layer.borderWidth = 2
        PlusPhotoButton.setImage(pcitureSelected.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
}
