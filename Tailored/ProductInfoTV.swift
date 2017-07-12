//
//  ProductInfoTV.swift
//  Tailored
//
//  Created by Daniel Lee on 2/18/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class ProductInfoTV: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: UITableViewStyle.plain)
        
        self.layer.cornerRadius = 10
//        self.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.85)
        self.backgroundColor = .clear
        self.bounces = false
        self.separatorColor = .black
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.allowsSelection = false

        self.delegate = self
        self.dataSource = self
        self.register(ProductInfoCell.self, forCellReuseIdentifier: "infoCell")
    }
    
    //MARK:  Product Info TableView
//    var infoTV: UITableView?
    var vcAddedTo: ProductVC? {
        didSet{
            selectedProduct = vcAddedTo?.selectedProduct
        }
    }
    var selectedProduct: Product?
    var productFeatures = [Any]()
    var productFeaturesImgNames = [String]()
    
    
    let removeBtn: UIButton = {
        let removeButton = UIButton()
        removeButton.setTitle("close", for: .normal)
        removeButton.titleLabel?.font = UIFont(name: "futura", size: 15)
        removeButton.setTitleColor(UIColor.white, for: .normal)
        removeButton.backgroundColor = UIColor(red: 0, green: 27/255, blue: 44/255, alpha: 1)
        return removeButton
    }()
    
    //MARK:  Display Product Info View
    func setUpInfoTV(viewAddedTo: ProductVC){
        
        vcAddedTo = viewAddedTo
        createProductFeaturesArray(product: selectedProduct!)
        self.reloadData()
        
        
        let WIDTH: CGFloat!
        let HEIGHT: CGFloat!
        
        if let window = UIApplication.shared.keyWindow {
            WIDTH = window.frame.width * 0.75
            HEIGHT = window.frame.height * 0.6
            let infoYPos: CGFloat = 0.13
    
            window.addSubview(self)
            self.frame = CGRect(x: window.center.x - (WIDTH/2), y: window.frame.height * infoYPos, width: WIDTH, height: HEIGHT)
        
            let removeBtnWidth = WIDTH * 0.15
            let removeBtnHeight = HEIGHT * 0.05
            removeBtn.frame = CGRect(x: window.center.x + (WIDTH/2) - removeBtnWidth, y: window.frame.height * infoYPos, width: removeBtnWidth, height: removeBtnHeight)
            removeBtn.addTarget(self, action: #selector(self.closeInfo), for: .touchUpInside)
            
            window.addSubview(removeBtn)
            
        }
        viewAddedTo.infoButton.isHidden = true
    }
    
    func closeInfo(){

        self.removeFromSuperview()
        removeBtn.removeFromSuperview()
        if let infoButton = vcAddedTo?.infoButton {
            infoButton.isHidden = false
        }
        
    }
    
    func createProductFeaturesArray(product: Product){
        
        productFeatures.removeAll()
        
        productFeatures.append(product.name)
        productFeatures.append(product.designer)
        productFeatures.append(product.price)
        
        productFeatures.append(product.metal)
        productFeatures.append(product.stone)
        productFeatures.append(product.carat)
        productFeatures.append(product.cut)
        productFeatures.append(product.color)
        productFeatures.append(product.clarity)
        
        productFeatures.append(product.size)
        productFeatures.append(product.description)
        productFeatures.append(product.quantity)
        
        productFeaturesImgNames = ["name", "designer", "price", "metal", "stone", "carat", "cut", "color", "clarity", "size", "description", "quantity"]
        
    }
    
    //------------------------------------
    // TABLEVIEW FUNCTIONS
    //------------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productFeatures.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.frame.height/10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProductInfoCell{
            
            let featureText = String("\(productFeatures[indexPath.row])")
            let featureImg = String("\(productFeaturesImgNames[indexPath.row])")
            cell.label.text = featureText
            cell.cellImage.image = UIImage(named: featureImg!)

            cell.setUpInfoTVCell()
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
