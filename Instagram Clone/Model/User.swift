//
//  UserModel.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/26.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import Foundation
import Firebase

class User
{
    
    var username: String?
    var fullname: String?
    var email: String?
    var profileImage: URL!
    var userID: String?
    var isFollowed: Bool = false
    
    init(dictionary:[String:Any])
    {
        self.username = dictionary["Username"] as? String ?? ""
        self.fullname = dictionary["Fullname"] as? String ?? ""
        self.email = dictionary["Email"] as? String ?? ""
        guard let imageURl = URL(string: dictionary["ProfileImageURL"] as? String ?? "") else {return}
        self.profileImage = imageURl
        self.userID = dictionary["UserId"] as? String ?? ""
    }
    
    
    func checkuserFollow(myUser: User ,myuserID: String, completion: @escaping(Bool) -> Void)
    {
        guard let letuseryoufollow = myUser.userID else {return}

        Database.database().reference().child("User-following").child(myuserID).child(letuseryoufollow).observeSingleEvent(of: .value) { datasnapshots in
            self.isFollowed = datasnapshots.exists()
            completion(self.isFollowed)
        }
    }
    
    
    
}
