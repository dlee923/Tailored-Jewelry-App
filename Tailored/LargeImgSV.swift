//
//  LargeImgSV.swift
//  Tailored
//
//  Created by Daniel Lee on 2/20/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class LargeImgSV: UIScrollView, UIScrollViewDelegate{

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
        self.bounces = false
        self.delegate = self
        self.maximumZoomScale = 2.0
        self.minimumZoomScale = 1.0

    }
    
    var lrgImageView: UIImageView?
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return lrgImageView

    }

    
    func largeImgSVSetUp(imageView: UIImageView, image: UIImage, currentVC: ProductVC){
        
        self.contentSize = imageView.frame.size
        
//        self.contentOffset = CGPoint(x: imageView.frame.width/8, y: imageView.frame.height/8)
        
        lrgImageView = imageView
    
    }
    
}
