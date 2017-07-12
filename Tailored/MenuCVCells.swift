//
//  MenuCVCells.swift
//  Tailored
//
//  Created by Daniel Lee on 2/27/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class MenuCVCells: UICollectionViewCell {


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpCell()
        
    }
    
    var menuOption: MenuOption? {
        didSet{
            label.text = menuOption?.menuName
            picture.image = UIImage(named: (menuOption?.menuImage)!)?.withRenderingMode(.alwaysTemplate)
            
        }
    }
    
    let label: UILabel = {
        let labelx = UILabel()
        let labelTitle = "text"
        let font = UIFont(name: "futura", size: 15)
        
        labelx.text = labelTitle
        labelx.font = font
        labelx.textColor = UIColor.white
        return labelx
    }()
    
    let picture: UIImageView = {
        let picturex = UIImageView()
        picturex.image = UIImage(named: "menu2")?.withRenderingMode(.alwaysTemplate)
        picturex.tintColor = .white
        picturex.contentMode = .scaleAspectFit
        return picturex
    }()
    
    let pictureScale: CGFloat = 0.5
    let textSpacer: CGFloat = 8
    
    func setUpCell() {
        self.addSubview(label)
        self.addSubview(picture)
        
        label.frame = CGRect(x: (self.frame.height * pictureScale) + (textSpacer * 2),
                             y: 0,
                             width: self.frame.width - textSpacer - (self.frame.height * pictureScale),
                             height: self.frame.height)
        
        picture.frame = CGRect(x: textSpacer,
                               y: self.frame.height * (pictureScale / 2),
                               width: (self.frame.height * pictureScale),
                               height: self.frame.height * pictureScale)
        
    }
}
