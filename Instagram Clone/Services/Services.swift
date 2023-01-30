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
}
