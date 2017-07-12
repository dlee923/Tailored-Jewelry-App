//
//  ImageViewExtension.swift
//  Tailored
//
//  Created by Daniel Lee on 2/21/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

extension UIImageView {

    func mainVCImageAttributes(imageview: UIImageView, image: String){
        
        imageview.image = UIImage(named: "\(image)")
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
    }
    
}
