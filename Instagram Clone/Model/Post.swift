//
//  Post.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/02/15.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import Foundation
import Firebase

class Post
{
    var user_id : String!
    var username: String!
    var fullname:String!
    var date: Date!
    var likes: Int!
    var post: String!
    var post_url: URL!
    var post_ID: String!
    var user: User?
    
    var didlike = false
    
    init(mypostID: String, user: User , dictionary: [String:Any])
    {
        self.user = user
        guard let postid = dictionary["post_id"] as? String else {return}
        
        if postid == mypostID
        {
            self.post_ID = postid
            
            guard let userid = dictionary["User_id"] as? String else {return}
            self.user_id = userid
            guard let username = dictionary["Username"] as? String else {return}
            self.username = username
            guard let fullName = dictionary["Fullname"] as? String else {return}
            self.fullname = fullName
            
            if let myDate = dictionary["Date"] as? Double
            {
                self.date = Date(timeIntervalSince1970: myDate)
            }
            
            guard let Post = dictionary["Post"] as? String else {return}
            self.post = Post
            guard let likes = dictionary["Likes"] as? Int else {return}
            self.likes = likes
            if let pictureurl = dictionary["Post-image-url"] as? String
            {
                self.post_url = URL(string: pictureurl)
                
            }
            
        }
        
    }
    
    func adjustlike(addlike: Bool)
    {
        if addlike
        {
            self.likes = self.likes + 1
            didlike = true
        }else
        {
            guard self.likes > 0 else {return}
            self.likes = self.likes - 1
            didlike = false
        }
        Database.database().reference().child("Posts").child(post_ID).child("Likes").setValue(self.likes)
    }
}
