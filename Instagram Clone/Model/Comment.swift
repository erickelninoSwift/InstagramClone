//
//  Comment.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/03/03.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import Foundation
import Firebase

class Comment
{
    var postid: String!
    var commentText: String!
   
    var userid: String!
    var dateCreation: Int!
//    var user: User?
    
    init(datavalue:[String:Any])
    {
        guard let postid = datavalue["Post-ID"] as? String else {return}
        guard let commenttext = datavalue["Comment"] as? String else {return}
        guard let userid = datavalue["Comment_User_id"] as? String else {return}
        guard let creationDate = datavalue["creationDate"] as? Int else {return}
//
//        Services.shared.fetchUser(user_Id: userid) { myUser in
//            self.user = myUser
//        }
        
        self.postid = postid
        self.commentText = commenttext

        self.userid = userid
        self.dateCreation = creationDate
    }
    
    

}
