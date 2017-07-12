//
//  LaunchVC.swift
//  Tailored
//
//  Created by Daniel Lee on 2/22/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class LaunchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tailorLogoSz = CGRect(x: self.view.center.x - (logoWidth/2),
                                  y: self.view.center.y - (logoHeight/2),
                                  width: logoWidth,
                                  height: logoHeight)

        startLogo = LogoView(frame: tailorLogoSz)
        startLogo.setUpImg()
        startLogo.contentMode = .scaleAspectFill
        startLogo.clipsToBounds = false
        
        self.view.addSubview(startLogo)
        
        self.view.backgroundColor = UIColor.white
        self.view.isOpaque = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        perform(#selector(self.dismissSplash), with: nil, afterDelay: 0.5)
        
    }
    
    //MARK: Start Up Logo Variables
    var startLogo: LogoView!
    
    let logoWidth: CGFloat = 100
    let logoHeight: CGFloat = 42
    
    func dismissSplash(){
        
        let finalPosition = startLogo.frame.offsetBy(dx: 0, dy: -(self.view.frame.height/2 - (logoHeight/2) - 21))
        let clearBackground = UIColor.clear
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: UIViewKeyframeAnimationOptions.calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                self.startLogo.frame = finalPosition
            })

            UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 1, animations:{
                self.view.backgroundColor = clearBackground
            })
            
        }, completion: {_ in self.dismissSelf()})
        
    }
    
    func dismissSelf(){
        self.dismiss(animated: false, completion: nil)
    }

}
