//
//  SuperviewConstraints.swift
//  Tailored
//
//  Created by Daniel Lee on 2/18/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

extension UIView {

    
    func lrgImageContainerSize(currentVC: UIViewController, container: UIView, pctHeight: CGFloat, header: CGFloat, statusBar: CGFloat, constant: CGFloat, constantActive: CGFloat){
        container.frame = CGRect(x: constant,
                                 y: constant,
                                 width: currentVC.view.frame.width - (constant * 2),
                                 height: (currentVC.view.frame.height  * pctHeight) - header - statusBar - constant - constantActive)
    }
    
}
