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

        
        Database.database().reference().child("Posts").child(userid).child(postid).observeSingleEvent(of: .value) { datasnaping in
            guard let currentdata = datasnaping.value as? [String:Any] else {return}
            Services.shared.fetchUser(user_Id: userid) { myUser in
                let post = Post(mypostID: postid, user: myUser, dictionary: currentdata)
                completion(post)
            }
            
        }
      
    }
    
    
    func fetchAllpost(userid: String , completion: @escaping(Post) -> Void)
    {
        
        guard let currentuserid = Auth.auth().currentUser?.uid else {return}
        print("DEBUG: MY IUID : \(currentuserid)")
        print("DEBUG: USERPOST ID  :\(userid)")
        Database.database().reference().child("User-Feeds").child(userid).observe(.childAdded) { datasnapshots in
            
             let postid = datasnapshots.key
            
            Services.shared.fetchUser(user_Id: userid) { MyUser in

                Database.database().reference().child("Posts").child(MyUser.userID!).child(postid).observeSingleEvent(of: .value) { datavaluesnap in
                    
                    guard let currentData = datavaluesnap.value as? [String:Any] else {return}
                    let elninomyPost = Post(mypostID: postid, user: MyUser, dictionary: currentData)
                    completion(elninomyPost)
                }
                
            }
           
            
        }
    }
}
