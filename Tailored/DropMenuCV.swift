//
//  DropMenuCV.swift
//  Tailored
//
//  Created by Daniel Lee on 2/27/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class MenuOption: NSObject {
    
    let menuName: String
    let menuImage: String
    
    init(name: String, image: String){
        self.menuName = name
        self.menuImage = image
    }
    
}

class DropMenuCV: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override init() {
        super.init()
        
        dropMenu.dataSource = self
        dropMenu.delegate = self
        dropMenu.register(MenuCVCells.self, forCellWithReuseIdentifier: "menuCell")
    }
    
    var navContainer: MainVC?

    // MARK:  Tableview Variables
    let dropMenu: UICollectionView = {
        
        let flow = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cv.layer.cornerRadius = 5
        cv.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)
        return cv
    
    }()
 
    let menuOptions = [MenuOption(name: "menu [x]", image: "menu2"),
                       MenuOption(name: "favorites", image: "heart2x"),
                       MenuOption(name: "full selection", image: "diamond"),
                       MenuOption(name: "shopping bag", image: "bag2"),]

    let menuSideSpace: CGFloat = 15

    func instantiateDropMenu(currentVC: UIViewController){

        if let window = UIApplication.shared.keyWindow {
            
            let width = window.frame.width/2.35
            dropMenu.frame = CGRect(x: menuSideSpace + (37/2), y: 20 + (37/2), width: 0, height: 0)
            window.addSubview(dropMenu)
            
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.25, options: .curveEaseIn, animations: {
                self.dropMenu.frame = CGRect(x: self.menuSideSpace, y: 20, width: width, height: window.frame.height * 0.4)
            }, completion: nil)
        }
        
        navContainer = currentVC as? MainVC
    }
    
    func dismissMenu(){
            
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.dropMenu.frame = CGRect(x: self.menuSideSpace + (37/2), y: 20 + (37/2), width: 0, height: 0)
        }, completion: {_ in
            self.dropMenu.removeFromSuperview()
        })
    }
    
    func dismissMenu2(){
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.dropMenu.frame = CGRect(x: -self.menuSideSpace - self.dropMenu.frame.width, y: 20, width: self.dropMenu.frame.width, height: self.dropMenu.frame.height)
        }, completion: {_ in
            self.dropMenu.removeFromSuperview()
        })
    }
    
    
    // MARK: - CollectionView Data Source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let numberOfItems = menuOptions.count
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            let tempSize = CGSize(width: dropMenu.bounds.width, height: dropMenu.bounds.height / CGFloat(menuOptions.count))
            return tempSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? MenuCVCells {
            cell.menuOption = menuOptions[indexPath.item]
            return cell
    
        } else {
            return UICollectionViewCell()
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.item {
        case 0 : dismissMenu()
        
        case 1 : dismissMenu2()
                 navContainer?.isFullSelection = false
                 navContainer?.refreshScrollView(productSVView: (navContainer?.productSVView)!, productSV: (navContainer?.productSV)!, productArray: (navContainer?.jewelryOptionsFav)!)
        
        case 2 : dismissMenu2()
                 navContainer?.isFullSelection = true
                 navContainer?.refreshScrollView(productSVView: (navContainer?.productSVView)!, productSV: (navContainer?.productSV)!, productArray: (navContainer?.jewelryOptions)!)
        
        case 3 : dismissMenu2()
                 let bagView = BagVC()
                 bagView.selectedProducts = (navContainer?.jewelryOptions.filter{$0.addedToCart})!
                 navContainer?.navigationController?.pushViewController(bagView, animated: true)
        
        default : print("default")
        }
        
    }
    
}
