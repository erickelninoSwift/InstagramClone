//
//  UserPostCellViewModel.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/02/17.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import Foundation
import Firebase

struct UserPostCellViewModel
{
    
    let currentPost: Post!
    
    var userID: String?
    {
        return currentPost.user_id
    }

    
}
