//
//  ProductDetailCollectionView.swift
//  Tailored
//
//  Created by Daniel Lee on 8/22/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import UIKit

class ProductDetailCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        
        self.register(ProductDetailCVCell.self, forCellWithReuseIdentifier: "DetailCell")
        self.dataSource = self
        self.delegate = self
        self.layer.backgroundColor = UIColor.clear.cgColor

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionViewLayout = layout
        //USE BELOW METHOD FOR CUSTOM PAGING??
//        layout.targetContentOffset(forProposedContentOffset: CGPoint, withScrollingVelocity: CGPoint)
        
        self.isPagingEnabled = false
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:  variables
    let CELLSPACING: CGFloat = 5
    let visibleCellCount: CGFloat = 3.5

    var selectProductImages = [String]() {
        didSet {
            self.reloadData()
        }
    }
    
    //MARK:  delegate functions
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as? ProductDetailCVCell{

            let imageName = selectProductImages[indexPath.item]
            cell.configureCell(imageName, cell: cell)
            
            return cell
            
        } else {
            return UICollectionViewCell()
            
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Needed to subtract 1 from height because automatically adjusts insets for scroll views called at viewcontroller runtime and logs unnecessary error regarding collectionview.
        return CGSize(width: superview!.frame.width/visibleCellCount, height: self.frame.height-1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CELLSPACING
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CELLSPACING
    }
    
    var parentVC = UIViewController() as? ProductVC
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        parentVC?.tempImg = indexPath.row
        
    }
    
    //MARK:  CollectionView Container Frame
    func cvContainerSize(currentVC: UIViewController, container: UIView, pctHeight: CGFloat, header: CGFloat, statusBar: CGFloat){
        container.frame = CGRect(x: 0,
                                 y: currentVC.view.frame.height - (currentVC.view.frame.height * pctHeight) - header - statusBar - CELLSPACING,
                                 width: currentVC.view.frame.width,
                                 height: currentVC.view.frame.height * pctHeight)
    }
    
    //MARK:  Collection View auto layout
    func passCurrentVCreference(currentVC: ProductVC){

        //Set reference to parent object
        parentVC = currentVC
    }

}
