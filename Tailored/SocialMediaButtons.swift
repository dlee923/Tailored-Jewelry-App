//
//  SocialMediaButtons.swift
//  Tailored
//
//  Created by Daniel Lee on 2/16/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class SocialMediaButtons: UIButton {

    var buttonSize = CGSize(width: 25, height: 25)
    var buttonSpacingY: CGFloat = 11
    var buttonSpacingX: CGFloat = 20
    var socialButtons = [UIButton]()
    var socialMedia = ["Twitter", "Instagram", "Facebook", "Snapchat", "Pinterest"]
    var socialImg =
        [
            "Twitter" : "twt",
            "Instagram" : "ig",
            "Facebook" : "fb",
            "Snapchat" : "sc",
            "Pinterest" : "pin"
        ]
    
    var socialLink =
        [
            "Twitter" : "http://www.twitter.com",
            "Instagram" : "http://www.instagram.com",
            "Facebook" : "http://www.facebook.com",
            "Snapchat" : "http://www.snapchat.com",
            "Pinterest" : "http://www.pinterest.com"
        ]
    
    func generateButtons(){
        
        for x in 0..<socialMedia.count {
            let emptyButton = UIButton()
            emptyButton.setImage(UIImage(named: socialImg[socialMedia[x]]!), for: .normal)
            emptyButton.alpha = 0.9
            emptyButton.addTarget(self, action: #selector(SocialMediaButtons.socialMediaLink), for: .touchUpInside)
            socialButtons.append(emptyButton)
        }
    }
    
    func socialMediaLink(){
        print("social media")
    }

}
