//
//  PostController.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/24.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit
import Firebase

class PostController: UIViewController
{
    
    lazy var profilepicture: UIImageView =
        {
            let propic = UIImageView()
            propic.translatesAutoresizingMaskIntoConstraints = false
            propic.clipsToBounds =  true
            propic.layer.masksToBounds = true
            propic.contentMode = .scaleAspectFill
            propic.backgroundColor = .darkGray
            NSLayoutConstraint.activate([propic.heightAnchor.constraint(equalToConstant: 90),
                                         propic.widthAnchor.constraint(equalToConstant: 90)
            ])
            
            propic.layer.cornerRadius = 90 / 2
            
            
            return propic
    }()
    
    
    lazy var myTextfield: UITextView =
        {
            let textfield = UITextView()
            textfield.translatesAutoresizingMaskIntoConstraints = false
            textfield.backgroundColor = .init(white: 0, alpha: 0.04)
            textfield.font = UIFont.preferredFont(forTextStyle: .body)
            textfield.textColor = .darkGray
            textfield.layer.cornerRadius = 5
            
            textfield.isScrollEnabled = true
            
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
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.isEnabled = false
            button.layer.cornerRadius = 5
            
            button.addTarget(self, action: #selector(HandleSharebutton), for: .primaryActionTriggered)
            
            return button
    }()
    
    var user: User?
    
    var myImage: UIImage?
    
    
    init(user: User, myImage: UIImage) {
        
        self.user = user
        self.myImage = myImage
        
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = "\(user.username ?? "")"
        configureImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextfield.delegate = self
        style()
        configure()
        handletextfield()
    }
}

extension PostController
{
    private func style()
    {
        view.backgroundColor = .white
        view.addSubview(profilepicture)
        view.addSubview(myTextfield)
        view.addSubview(shareButton)
        
        
    }
    private func configure()
    {
        NSLayoutConstraint.activate([profilepicture.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
                                     profilepicture.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([myTextfield.leadingAnchor.constraint(equalToSystemSpacingAfter: profilepicture.trailingAnchor, multiplier: 1),
                                     myTextfield.topAnchor.constraint(equalTo: profilepicture.topAnchor),
                                     view.trailingAnchor.constraint(equalToSystemSpacingAfter: myTextfield.trailingAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([shareButton.topAnchor.constraint(equalToSystemSpacingBelow: myTextfield.bottomAnchor, multiplier: 1),
                                     shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     shareButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
                                     view.trailingAnchor.constraint(equalToSystemSpacingAfter: shareButton.trailingAnchor, multiplier: 1)
        ])
    }
    
    
    @objc func HandleSharebutton()
    {
        guard let postText = myTextfield.text,
            let myimage = profilepicture.image,
            let currentuserID = Auth.auth().currentUser?.uid else {return}
        self.savePost(post: postText, PostImage: myimage, userID: currentuserID)
    }
    
    
    
    private func handletextfield()
    {
        shareButton.isEnabled = !myTextfield.text.isEmpty ? true : false
        shareButton.backgroundColor = shareButton.isEnabled ? UIColor(red: 0/255, green: 120/255, blue: 175/255, alpha: 1) : UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
    }
    
    private func configureImage()
    {
        guard let currentimage = myImage else {return}
        guard let currentUser = user else {return}
        self.profilepicture.image = currentimage
        print("DEBUG: USER : \(currentUser.fullname ?? "")")
    }
    
}

extension PostController: UITextViewDelegate
{
    func textViewDidChange(_ textView: UITextView) {
        handletextfield()
    }
}

extension PostController
{
    // SAVE POST FUNCTION
    
    
    func savePost(post: String , PostImage: UIImage ,  userID: String)
    {
        guard let imageData = PostImage.jpegData(compressionQuality: 0.5) else {return}
        
        
        let filename = NSUUID().uuidString
        
        let storage = Storage.storage().reference().child("Post-Images").child(filename)
        
        //cretation date
        
        let currentDate = Int(NSDate().timeIntervalSince1970)
        
        storage.putData(imageData) { (storageMata, Error) in
            if let error = Error
            {
                print("DEBUG: There was an error while saving post image : \(error.localizedDescription)")
                return
            }
            
            storage.downloadURL { (url, Error) in
                if let error  = Error
                {
                    print("DEBUG: Error found while downloading Image URl : \(error.localizedDescription)")
                    return
                }
                
                guard let postImageUrl = url?.absoluteString else {return}
                
                Services.shared.fetchUser(user_Id: userID) { elninouser in
                    var dictionary = ["User_id": elninouser.userID ?? "" , "Username": elninouser.username ?? "", "Fullname":elninouser.fullname ?? "","Post-image-url" : postImageUrl, "Date" : currentDate,"Post": post,"Likes": 0] as [String:Any]
                    Database.database().reference().child("Posts").child(elninouser.userID!).childByAutoId().updateChildValues(dictionary) { (Error, Dataref) in
                        if let error = Error
                        {
                            print("DEBUG: There was an error while trying to save your post : \(error.localizedDescription)/")
                            return
                        }
                        
                        
                        guard let postid = Dataref.key else {return}
                        
                        dictionary["post_id"] = postid
                        Dataref.updateChildValues(dictionary)
    
                        let value = [postid: 1] as [String:Any]
                        
                        Database.database().reference().child("User-posts").child(userID).updateChildValues(value) { (Error, datareference) in
                            if let error  = Error
                            {
                                print("DEBUG: There was an error while saving user post : \(error.localizedDescription)")
                                return
                            }
                            
                            print("DEBUG: Saved Succesfully")
                            self.navigationController?.dismiss(animated: true, completion: nil)
                        }
                    }
                    
                }
            }
            
        }
        
    }
    
    
}



