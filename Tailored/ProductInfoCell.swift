//
//  ProductInfoCell.swift
//  Tailored
//
//  Created by Daniel Lee on 2/18/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class ProductInfoCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var cellImage: UIImageView = {
        let imageX = UIImageView()
        imageX.contentMode = .scaleAspectFit
        return imageX
    }()
    
    var label: UILabel = {
        let labelx = UILabel()
        labelx.text = "label"
        labelx.textColor = .black
        labelx.font = UIFont(name: "futura", size: 13)
        return labelx
    }()

    let frameSpacer: CGFloat = 5
    
    func setUpInfoTVCell(){
        self.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.85)
        
        let imgBorderSize = self.frame.height * 0.5
        
        cellImage.frame = CGRect(x: frameSpacer, y: (self.frame.height - imgBorderSize)/2, width: imgBorderSize, height: imgBorderSize)
        
        let lblWidthSize = self.frame.width - imgBorderSize - cellImage.frame.origin.x - frameSpacer
        let lblHeightSize = self.frame.height * 1
        label.frame = CGRect(x: imgBorderSize + cellImage.frame.origin.x + frameSpacer, y: (self.frame.height - lblHeightSize)/2, width: lblWidthSize, height: lblHeightSize)

//        label.layer.cornerRadius = 3
//        label.clipsToBounds = true
        
        self.addSubview(label)
        self.addSubview(cellImage)
    }

}
