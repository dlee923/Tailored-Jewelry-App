//
//  LogoView.swift
//  Tailored
//
//  Created by Daniel Lee on 8/11/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import UIKit

class LogoView: UIImageView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    func setUpImg(){
        self.image = tailorLogoImg
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
    }
    
    func setUpImg2(){
        self.image = tailorLogoImg2
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
    }
    
    let tailorLogoImg = UIImage(named: "tailored_logo_trans_drop")
    let tailorLogoImg2 = UIImage(named: "ct_logo_trans_gold")
}
