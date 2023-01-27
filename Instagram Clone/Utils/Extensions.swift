//
//  Extensions.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/21.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit
import SDWebImage

extension UIView
{
    func anchor(top: NSLayoutYAxisAnchor?,left: NSLayoutXAxisAnchor?, bottom : NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,paddingTop: CGFloat,paddingBottom: CGFloat, paddingLeft: CGFloat, paddingRight: CGFloat, Height: CGFloat, Width:CGFloat)
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top
        {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left
        {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let right = right
        {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let bottom = bottom
        {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if Width != 0
        {
            self.widthAnchor.constraint(equalToConstant: Width).isActive = true
        }
        
        if Height != 0
        {
            self.heightAnchor.constraint(equalToConstant: Height).isActive = true
        }
    }
}


extension UIColor
{
    var AppColor: UIColor
    {
        return UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
    }
}


extension UIImageView
{
    func loadImage(with ImageURL: URL)
    {
        
        self.sd_setImage(with: ImageURL, completed: nil)
        
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: ImageURL) { (data, response , error) in
                guard let ImageData = data else {return}
                DispatchQueue.main.async {
                     self.image = UIImage(data: ImageData)
                }
            }.resume()
        }
        
        
    }
}
