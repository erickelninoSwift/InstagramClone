//
//  UserModel.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/26.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import Foundation

struct User
{
    var username: String?
    var fullname: String?
    var email: String?
    var profileImage: URL!
    var userID: String?
    
    init(dictionary:[String:Any])
    {
        self.username = dictionary["Username"] as? String ?? ""
        self.fullname = dictionary["Fullname"] as? String ?? ""
        self.email = dictionary["Email"] as? String ?? ""
        guard let imageURl = URL(string: dictionary["ProfileImageURL"] as? String ?? "") else {return}
        self.profileImage = imageURl
        self.userID = dictionary["UserId"] as? String ?? ""
    }
}
