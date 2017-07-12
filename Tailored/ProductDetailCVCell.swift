//
//  ProductDetailCVCell.swift
//  Tailored
//
//  Created by Daniel Lee on 9/11/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import UIKit

class ProductDetailCVCell: UICollectionViewCell {
    
    //MARK:  Cell Variables
    var detailImgView: UIView!
    var detailImg: UIImageView!
    
    //MARK:  Cell Set Up
    func configureCell(_ image: String, cell: UICollectionViewCell){
        
        detailImg = UIImageView()
        cell.layer.backgroundColor = UIColor.blue.cgColor
        cell.layer.cornerRadius = 5
        detailImg.image = UIImage(named: image)
        detailImg.frame = cell.bounds
        detailImg.contentMode = .scaleAspectFill
        detailImg.clipsToBounds = true
        cell.clipsToBounds = true
        
        cell.addSubview(detailImg)
    }
    
}
