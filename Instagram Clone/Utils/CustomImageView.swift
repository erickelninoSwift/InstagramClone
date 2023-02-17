//
//  CustomImageView.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/02/16.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit
import SDWebImage

class CustomImageView: UIImageView
{
    
    var lastImageUrlString: URL?
    
    func loadImage(with ImageURL: URL)
    {
        
        
        self.image = nil
        
        self.lastImageUrlString = ImageURL
        
//        self.sd_setImage(with: ImageURL, completed: nil)
//        
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: ImageURL) { (data, response , error) in
                guard let ImageData = data else {return}
                
                if self.lastImageUrlString != ImageURL
                {
                    return
                }
                DispatchQueue.main.async {
                    self.image = UIImage(data: ImageData)?.withRenderingMode(.alwaysOriginal)
                }
            }.resume()
        }
        
        
    }
}
