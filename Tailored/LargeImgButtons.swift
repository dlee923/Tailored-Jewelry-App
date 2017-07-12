//
//  LargeImgButtons.swift
//  Tailored
//
//  Created by Daniel Lee on 2/21/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

//--------------------------------------------------------
// FAVORITE / LOVE IT BUTTON
//--------------------------------------------------------

class LoveButton: UIButton {
    
    let heart1 = "heart1.png"
    let heart1Click = "heart1Click.png"
    let heart2 = "heart2.png"
    let heart2Click = "heart2Click.png"
    let btnSize: CGFloat = 0.15
    var btnInset: CGFloat = 5
    var buttonStatus = 0
    var selectedProduct: Product?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.alpha = 0.7
        self.imageEdgeInsets = UIEdgeInsetsMake(btnInset, btnInset, btnInset, btnInset)
        selectLoveButton(image: heart2)
        self.addTarget(self, action: #selector(self.selectLoveButtonOn), for: .touchUpInside)
    }
    
    func selectLoveButtonOn(){
        selectLoveButton(image: heart2Click)
        self.addTarget(self, action: #selector(self.selectLoveButtonOff), for: .touchUpInside)
        selectedProduct?.favorite = true
    }
    
    func selectLoveButtonOff(){
        selectLoveButton(image: heart2)
        self.addTarget(self, action: #selector(self.selectLoveButtonOn), for: .touchUpInside)
        selectedProduct?.favorite = false
    }
    
    func selectLoveButton(image: String){
        
        let loveImage = UIImage(named: "\(image)")!
        self.setImage(loveImage, for: .normal)
    }
    
    func loveButtonConstraints(superview: UIView, applyToObject: UIButton){
        
        superview.addSubview(applyToObject)
        let btnSides = superview.frame.width * btnSize
        
        applyToObject.frame = CGRect(x: superview.frame.width - btnSides, y: superview.frame.height - btnSides, width: btnSides, height: btnSides)
    }
}

//--------------------------------------------------------
// INFORMATION BUTTON
//--------------------------------------------------------

class InfoButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTitle("details", for: .normal)
        self.titleLabel?.font = UIFont(name: "futura", size: 15)
        self.contentHorizontalAlignment = .left

        self.titleLabel?.textColor = UIColor.white
    }

    func setUpInfoBtn(container: UIView, applyToView: UIButton){
        
        let infoHeight: CGFloat = container.frame.height * 0.05
        let infoWidth: CGFloat = container.frame.width * 0.2
        container.addSubview(applyToView)
        applyToView.frame = CGRect(x: 5, y: container.frame.height - infoHeight, width: infoWidth, height: infoHeight)
    }
}

//--------------------------------------------------------
// ARROW / NEXT IMAGE BUTTONS
//--------------------------------------------------------

class NextArrow: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.alpha = 0.6
        
    }
    
    let rightArrow = "nextArrowR"
    let rightArrow2 = "nextArrowR2"
    let leftArrow = "nextArrowL"
    let leftArrow2 = "nextArrowL2"
    var arrowWidth: CGFloat!
    var arrowHeight: CGFloat = 75
    var xPosition: CGFloat!
    
    
    func setUpArrow(direction: String, container: UIView, applyToView: UIButton){
        
        container.addSubview(applyToView)
        
        arrowWidth = container.frame.width * 0.08
        
        applyToView.setImage(UIImage(named: direction), for: .normal)
        
        if direction == "nextArrowL" {
            xPosition = 0
        } else if direction == "nextArrowR" {
            xPosition = container.frame.width - arrowWidth
        }
        
        applyToView.frame = CGRect(x: xPosition, y: container.frame.height/2 - arrowHeight/2, width: arrowWidth, height: arrowHeight)
        
    }
    
}

//--------------------------------------------------------
// ADD TO CART BUTTON
//--------------------------------------------------------

class AddButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.setImage(UIImage(named: "add")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.tintColor = .white
        
    }
    
    var selectedProduct: Product?
    var currentVC: ProductVC?
    
    let buttonSize: CGFloat = 37
    let edgeSpacer: CGFloat = 7
    
    func setUpAddButton(container: UIView, applyToView: UIButton, vc: ProductVC){
        currentVC = vc
        container.addSubview(applyToView)
        applyToView.frame = CGRect(x: container.frame.width - buttonSize - edgeSpacer, y: edgeSpacer, width: buttonSize, height: buttonSize)
        self.addTarget(self, action: #selector(self.addButtonPressed), for: .touchUpInside)
    }
    
    func addButtonPressed(){
        selectedProduct?.addedToCart = true
        
        let added = UIAlertController(title: "Success", message: "Item has been added to bag", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Continue", style: .default, handler: nil)
        let checkOut = UIAlertAction(title: "Check Out", style: .default) { (finished) in
            self.currentVC?.navBtn.accessBag()
        }
        added.addAction(okay)
        added.addAction(checkOut)
        currentVC!.present(added, animated: true, completion: nil)
        
        print("added to bag")
    }
    
}
