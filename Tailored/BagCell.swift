//
//  BagCell.swift
//  Tailored
//
//  Created by Daniel Lee on 3/6/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class BagCell: UICollectionViewCell {
    
    let productImage: UIImageView = {
        let productImageX = UIImageView()
        productImageX.backgroundColor = .purple
        productImageX.image = UIImage(named: "feature")
        productImageX.contentMode = .scaleAspectFill
//        productImageX.layer.cornerRadius = productImageX.frame.width/2
        productImageX.clipsToBounds = true
        
        return productImageX
    }()
    
    let label1: UILabel = {
        let label = UILabel()
        label.text = "name of product"
        label.textColor = UIColor(white: 0.9, alpha: 1)
        label.font = UIFont(name: "futura", size: 20)
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.text = "designer here"
        label.textColor = UIColor(white: 0.9, alpha: 1)
        label.font = UIFont(name: "futura", size: 10)
        return label
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.text = "$10,000"
        label.textColor = UIColor(white: 0.9, alpha: 1)
        label.font = UIFont(name: "futura", size: 13)
        label.textAlignment = .right
        return label
    }()
    
    let edgeSpacer: CGFloat = 3
    let edgeSpacer2: CGFloat = 6
    
    func setUpCartCell(){
        
        self.backgroundColor = UIColor(white: 1, alpha: 0.3)
        self.layer.cornerRadius = 5
        
        self.addSubview(productImage)
        self.addSubview(label1)
        self.addSubview(label2)
        self.addSubview(label3)

        productImage.frame = CGRect(x: edgeSpacer,
                                    y: edgeSpacer,
                                    width: self.frame.height - (edgeSpacer * 2),
                                    height: self.frame.height - (edgeSpacer * 2))
        
        productImage.layer.cornerRadius = productImage.frame.width/2
        
        label1.frame = CGRect(x: edgeSpacer + productImage.frame.width + edgeSpacer2,
                              y: edgeSpacer,
                              width: self.frame.width - productImage.frame.width - (edgeSpacer * 2) - edgeSpacer2,
                              height: (self.frame.height - (edgeSpacer * 2))*(2/5))
        
        label2.frame = CGRect(x: edgeSpacer + productImage.frame.width + edgeSpacer2,
                              y: edgeSpacer + label1.frame.height,
                              width: self.frame.width - productImage.frame.width - (edgeSpacer * 2) - edgeSpacer2,
                              height: (self.frame.height - (edgeSpacer * 2))*(1.5/5))
        
        label3.frame = CGRect(x: edgeSpacer + productImage.frame.width + edgeSpacer2,
                              y: edgeSpacer + label1.frame.height + label2.frame.height,
                              width: self.frame.width - productImage.frame.width - (edgeSpacer * 2) - edgeSpacer2,
                              height: (self.frame.height - (edgeSpacer * 2))*(1.5/5))
    }
}
