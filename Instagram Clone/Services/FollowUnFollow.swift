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
    
    static var userisFollowed = false
    
    func followUser(usertoFollow: User)
    {
        guard let userid = Auth.auth().currentUser?.uid else {return}
        FollowUnFollow.userisFollowed = true
         let followingvalue = [usertoFollow.userID: 1]
        let followersvalue = [userid:1]
        
        Database.database().reference().child("User-following").child(userid).updateChildValues(followingvalue)
        Database.database().reference().child("User-followers").child(usertoFollow.userID ?? "").updateChildValues(followersvalue)
        
    }
    
    
    func UnfollowUser(usertoUnfollow: User)
    {
        guard let userid = Auth.auth().currentUser?.uid else {return}
        FollowUnFollow.userisFollowed = false
        Database.database().reference().child("User-following").child(userid).child(usertoUnfollow.userID!).removeValue { (Error, Dataref) in
            if  Error != nil
            {
                print("DEBUG: Error Found while unfollowing User : \(Error!.localizedDescription)")
                return
            }
            
            Database.database().reference().child("User-followers").child(usertoUnfollow.userID!).child(userid).removeValue()
        }
    }
}
