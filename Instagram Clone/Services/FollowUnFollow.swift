//
//  FollowUnFollow.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/30.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import Foundation
import Firebase


class FollowUnFollow
{
    static let shared = FollowUnFollow()
    
     var userisFollowed = false
    
    func followUser(usertoFollow: User)
    {
        guard let userid = Auth.auth().currentUser?.uid else {return}
        self.userisFollowed = true
         let followingvalue = [usertoFollow.userID: 1]
        let followersvalue = [userid:1]
        
        Database.database().reference().child("User-following").child(userid).updateChildValues(followingvalue)
        Database.database().reference().child("User-followers").child(usertoFollow.userID ?? "").updateChildValues(followersvalue)
        
    }
    
    
    func UnfollowUser(usertoUnfollow: User)
    {
        guard let userid = Auth.auth().currentUser?.uid else {return}
        self.userisFollowed = false
        Database.database().reference().child("User-following").child(userid).child(usertoUnfollow.userID!).removeValue { (Error, Dataref) in
            if  Error != nil
            {
                print("DEBUG: Error Found while unfollowing User : \(Error!.localizedDescription)")
                return
            }
            
            Database.database().reference().child("User-followers").child(usertoUnfollow.userID!).child(userid).removeValue()
        }
    }
    
    
    func checkuserFollow(myUser: User , completion: @escaping(Bool) -> Void)
    {
        guard let userid = Auth.auth().currentUser?.uid else {return}
        guard let letuseryoufollow = myUser.userID else {return}
        
        
        Database.database().reference().child("User-following").child(userid).child(letuseryoufollow).observeSingleEvent(of: .value) { datasnapshots in
           self.userisFollowed = datasnapshots.exists()
            completion(datasnapshots.exists())
        }
        
        Database.database().reference().child("User-followers").child(myUser.userID!).child(userid).observeSingleEvent(of: .value) { Datasnapshots in
             self.userisFollowed = Datasnapshots.exists()
            completion(Datasnapshots.exists())
        }
    }
}
