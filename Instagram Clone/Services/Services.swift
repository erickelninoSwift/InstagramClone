//
//  Services.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/28.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit
import Firebase

class Services
{
    static let shared = Services()
    
    func fetchUser(user_Id : String, completion: @escaping(User) -> Void)
    {
        Database.database().reference().child("Users").child(user_Id).observeSingleEvent(of: .value) { snapshots in
            
            guard let userdata = snapshots.value as? [String:Any] else {return}
            let user = User(dictionary: userdata)
            completion(user)
        }
    }
    
    
    func fetchPost(userid: String,postid: String, completion: @escaping(Post) -> Void)
    {

        Database.database().reference().child("Posts").observe(.childAdded) { datafound in
            guard datafound.key == postid else {return}
            guard let data = datafound.value as? [String:Any] else {return}
            self.fetchUser(user_Id: userid) { elninoUser in
                let myPost  = Post(mypostID: datafound.key, user: elninoUser, dictionary: data)
                completion(myPost)
            }
        }
      
    }
    
    
    func fetchAllpost(completion: @escaping(Post) -> Void)
    {
        guard let currentuserid = Auth.auth().currentUser?.uid else {return}

        Database.database().reference().child("User-Feeds").child(currentuserid).observe(.childAdded) { datasnapshots in
            let myPostID = datasnapshots.key
            
            Database.database().reference().child("Posts").child(myPostID).observeSingleEvent(of: .value) { DataPostsnap in
                guard let data = DataPostsnap.value as? [String:Any] else {return}
                Services.shared.fetchUser(user_Id: currentuserid) { myUser in
                    let posts = Post(mypostID: myPostID, user: myUser, dictionary: data)
                    completion(posts)
                }
            }
        }
    }
}
