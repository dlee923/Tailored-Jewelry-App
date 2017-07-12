//
//  NavButton.swift
//  Tailored
//
//  Created by Daniel Lee on 2/16/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class NavButton: UIBarButtonItem {

    let cart1 = "cart1.png"
    let cart2 = "cart2.png"
    let menu = "menu.png"
    let menu2 = "menu2.png"
    let bag1 = "bag1.png"
    let bag2 = "bag2.png"
    let buttonSizeH = 37
    let buttonSizeW = 37
    var selectedVC: UIViewController?
    
    func setUpBarBtn(item: String, currentVC: UIViewController) -> UIBarButtonItem {
        
        let button = UIButton(type: .system)
        
        button.frame = CGRect(x: 0, y: 0, width: buttonSizeW, height: buttonSizeH)
        button.setImage(UIImage(named: "\(item)"), for: .normal)
        
        switch item {
            case bag2 : button.addTarget(self, action: #selector(self.accessBag), for: .touchUpInside)
                        button.setTitle("Items In Bag", for: .normal)
            case menu2 : button.addTarget(self, action: #selector(self.dropMenu), for: .touchUpInside)
                         button.setTitle("Menu", for: .normal)
            default: break
        }

        button.backgroundColor = UIColor.white

        let barButton = UIBarButtonItem(customView: button)
        
        selectedVC = currentVC
        
        return barButton
    }

    let bagView = BagVC()
    
    func accessBag(){
        
        if let fromView = selectedVC as? MainVC {
            bagView.selectedProducts = fromView.jewelryOptions.filter{$0.addedToCart == true}
        }
        
        if let fromView2 = selectedVC as? ProductVC {
            bagView.selectedProducts = (fromView2.jewelryOptions?.filter{$0.addedToCart == true})!
        }
        
        selectedVC?.navigationController?.pushViewController(bagView, animated: true)

        menuClass.dismissMenu()

    }
    
    let menuClass = DropMenuCV()
    
    func dropMenu(){
        menuClass.instantiateDropMenu(currentVC: selectedVC!)
    }
    
    
}
