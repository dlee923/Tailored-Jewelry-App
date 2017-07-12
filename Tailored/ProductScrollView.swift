//
//  ProductScrollView.swift
//  Tailored
//
//  Created by Daniel Lee on 8/13/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import UIKit

class ProductScrollView: UIScrollView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    //MARK:  ScrollView Data Variables
    var productImages = [UIImageView]()
    var singleImageView: UIView!
    var yImageSpacer: CGFloat = 20.0
    var xImageSpacer: CGFloat = 5.0
    var svSizer: CGFloat = 1
    var offsetPercentage: CGFloat = 1
    var minOffsetPercentage: CGFloat = 0
    var normalHeight: CGFloat = 0.8
    var featureHeight: CGFloat = 1.0
    var heightGap: CGFloat!
    var scrollWidth: CGFloat!
    var scrollHeight: CGFloat!
    
    //MARK:  ScrollView IB Attributes
    var scrollViewSize: CGRect!
    var scrollViewPaging: Bool!
    var singleImageSize: CGRect!
    var pageController: UIPageControl!
    var currentPage: Int!
    
    //MARK:  Manually add views
    func manuallyAddViews(productSeries: [Product]){
        
        productImages.removeAll()
        
        for x in 0..<productSeries.count {
            let view = UIImageView()
            view.mainVCImageAttributes(imageview: view, image: productSeries[x].photoName)
            productImages.append(view)
            
        }
        
    }
    
    //MARK:  Configuring scrollview
    func setUpScrollView(_ productImages: [UIView]){
        scrollWidth = superview!.bounds.width
        scrollHeight = superview!.bounds.height
        
        // set size of scroll view frame
        scrollViewSize = CGRect(x: 0,
                                y: 0,
                                width: scrollWidth,
                                height: scrollHeight)
        
        self.showsHorizontalScrollIndicator = false
        self.bounds = scrollViewSize
        self.center = CGPoint(x: scrollWidth/2,
                              y: scrollHeight/2)
        
        // set size of scroll view content
        self.contentSize = CGSize(width: (scrollWidth * svSizer) * CGFloat(productImages.count),
                                  height: scrollHeight)
        
        self.isPagingEnabled = true
        
        // set up page control
        pageController = UIPageControl(frame: CGRect(x: ((scrollWidth * 0.1)/2),
                                                     y: 10,
                                                     width: (scrollWidth * 0.9),
                                                     height:(yImageSpacer * 0.2)))
        
        pageController.clipsToBounds = true
        pageController.numberOfPages = productImages.count
        pageController.currentPage = productImages.count
        pageController.pageIndicatorTintColor = UIColor.lightGray
        pageController.currentPageIndicatorTintColor = UIColor.darkGray
        superview!.addSubview(pageController)
        
        self.contentOffset = CGPoint(x: (scrollWidth * svSizer) * CGFloat(productImages.count-1),
                                     y: 0)
        
        if productImages.count == 1 {
            viewCurrentView(pageNum: 0)
            currentPage = 0
        }
    }
    
    func pageCurrentPage(){
        currentPage = Int(contentOffset.x / (superview!.bounds.width * svSizer) + CGFloat(0.5))
        pageController.currentPage = Int(currentPage)
    }
    
    func viewCurrentView(pageNum: Int){
        scrollWidth = superview!.bounds.width
        scrollHeight = superview!.bounds.height
        
        heightGap = featureHeight - normalHeight
        offsetPercentage = ((scrollWidth) - abs(((scrollWidth * CGFloat(pageNum)) + (scrollWidth/2)) - ((contentOffset.x) + scrollWidth/2)))
            /
            (scrollWidth)
        
        if offsetPercentage > 1 {
            offsetPercentage = 1
        } else if offsetPercentage < minOffsetPercentage {
            offsetPercentage = minOffsetPercentage
        }
        
//        print(productImages[pageNum].frame)
        
        // set up images
        for x in 0 ..< productImages.count {
            if x == pageNum {
                singleImageSize = CGRect(
                    x: (scrollWidth * svSizer) * CGFloat(x) + xImageSpacer,
                    y: yImageSpacer + (((scrollHeight * heightGap)/2) * (1 - offsetPercentage)),
                    width: (scrollWidth * svSizer)-(xImageSpacer*2),
                    height: (scrollHeight * (normalHeight + (heightGap * offsetPercentage))) - (yImageSpacer*2)
                )
                
                // Not working when adding an image???  why is that
                productImages[x].layer.shadowColor = UIColor.black.cgColor
                productImages[x].layer.shadowOffset = CGSize(width: 10, height: 10)
                productImages[x].layer.shadowRadius = 10
                productImages[x].layer.shadowOpacity = 0.65
                
            } else {
                singleImageSize = CGRect(
                    x: (scrollWidth * svSizer) * CGFloat(x) + xImageSpacer,
                    y: yImageSpacer + ((scrollHeight * heightGap)/2),
                    width: (scrollWidth * svSizer)-(xImageSpacer*2),
                    height: (scrollHeight * normalHeight) - (yImageSpacer*2)
                )
                productImages[x].layer.shadowOpacity = 0
                
            }
            singleImageView = productImages[x]
            singleImageView.frame = singleImageSize
            singleImageView.layer.cornerRadius = 5
            
            self.addSubview(singleImageView)
        }
    }
    
}
