//
//  ProductVC.swift
//  Tailored
//
//  Created by Daniel Lee on 8/8/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import UIKit

class ProductVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
//        let logoView = LogoView(frame: tailorLogoSz)
//        logoView.setUpImg()
//        self.navigationItem.titleView = logoView
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor(red: 0, green: 27/255, blue: 44/255, alpha: 1),
            NSFontAttributeName: UIFont(name: "futura", size: 15)!
        ]
        
        setUpLargeImg()
        setUpSmallProductView()
        setupNavBtn()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = selectedProduct.name.uppercased()
        checkFavoriteStatus(product: self.selectedProduct)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if imageRollActive {
            revealImages()
        }
        
        infoTV.closeInfo()
    }

    //----------------------------------------------------------
    // VARIABLES
    //----------------------------------------------------------
    
    //MARK:  View Controller Data
    var selectedProduct: Product! {
        didSet {
            selectProductImages.removeAll()
            selectProductImages.append(selectedProduct.photoName1)
            selectProductImages.append(selectedProduct.photoName2)
            selectProductImages.append(selectedProduct.photoName3)
            selectProductImages.append(selectedProduct.photoName4)
            selectProductImages.append(selectedProduct.photoName)
            
            productDetailCV.selectProductImages = self.selectProductImages
        }
    }
    var selectProductImages = [String]()

    var jewelryOptions: [Product]?
    
    //MARK:  General View Controller Variables
    let navBtn = NavButton()
    let tailorLogoSz = CGRect(x: 0,
                              y: 0,
                              width: 100,
                              height: 42)
    
    //MARK:  Small Product Image View
    var productDetailCV = ProductDetailCollectionView()
    var imageRollActive = false
    
    
    //----------------------------------------------------------
    // FUNCTIONS
    //----------------------------------------------------------
    
    //MARK:  Set Up Menu Buttons
    func setupNavBtn(){
        
        var emptyBtn: UIBarButtonItem?
        
        emptyBtn = navBtn.setUpBarBtn(item: navBtn.bag2, currentVC: self)
        self.navigationItem.rightBarButtonItem = emptyBtn
        
    }
    
    
    //MARK:  Setup Small Product Image View (SCROLL VIEW)
    func setUpSmallProductView(){

        self.view.addSubview(productDetailCV)
        
        //INITIAL HEIGHT
        productDetailCV.cvContainerSize(currentVC: self, container: productDetailCV, pctHeight: 0.0, header: 44, statusBar: 20)
        
        productDetailCV.passCurrentVCreference(currentVC: self)
    }
    
    
    func revealImages(){
        
        switch imageRollActive {
        
        //FINAL HEIGHT
        case false : UIView.animate(withDuration: 0.2, animations: {
            
            self.productDetailCV.cvContainerSize(currentVC: self, container: self.productDetailCV, pctHeight: 0.2, header: 0, statusBar: 0)
            
            self.seeImagesBtn.setTitle("hide images", for: .normal)
            
            self.scrollViewFoundation.lrgImageContainerSize(currentVC: self, container: self.scrollViewFoundation, pctHeight: 0.8, header: 0, statusBar: 0, constant: self.productDetailCV.CELLSPACING, constantActive: (self.productDetailCV.CELLSPACING * 2))
            self.productSuper.frame = self.scrollViewFoundation.bounds
            self.loveButton.frame.origin.y = self.scrollViewFoundation.frame.height - self.loveButton.frame.height
            self.arrowBtn.frame.origin.y = self.scrollViewFoundation.frame.height/2 - self.arrowBtn.frame.height/2
            self.arrowBtn2.frame.origin.y = self.scrollViewFoundation.frame.height/2 - self.arrowBtn2.frame.height/2
            self.infoButton.frame.origin.y = self.scrollViewFoundation.frame.height - self.infoButton.frame.height
            self.seeImagesBtn.frame.origin.y = self.scrollViewFoundation.frame.height - self.seeImagesBtn.frame.height
            self.changeLargeImg(imageName: self.selectProductImages[self.tempImg], imageView: self.productLargeImgView, currentVC: self)
            
            })
        
            imageRollActive = true
        
        case true : UIView.animate(withDuration: 0.2, animations: {
            self.productDetailCV.cvContainerSize(currentVC: self, container: self.productDetailCV, pctHeight: 0.0, header: 0, statusBar: 0)

            //-------------------------
            // need to keep cell height same size or else will instantly disappear.  Doesn't matter.  CV dequeue's cells regardless of size...
            //-------------------------
            
            self.seeImagesBtn.setTitle("see all images", for: .normal)
            
            self.scrollViewFoundation.lrgImageContainerSize(currentVC: self, container: self.scrollViewFoundation, pctHeight: 1.0, header: 0, statusBar: 0, constant: self.productDetailCV.CELLSPACING, constantActive: self.productDetailCV.CELLSPACING)
            self.productSuper.frame = self.scrollViewFoundation.bounds
            self.loveButton.frame.origin.y = self.scrollViewFoundation.frame.height - self.loveButton.frame.height
            self.arrowBtn.frame.origin.y = self.scrollViewFoundation.frame.height/2 - self.arrowBtn.frame.height/2
            self.arrowBtn2.frame.origin.y = self.scrollViewFoundation.frame.height/2 - self.arrowBtn2.frame.height/2
            self.infoButton.frame.origin.y = self.scrollViewFoundation.frame.height - self.infoButton.frame.height
            self.seeImagesBtn.frame.origin.y = self.scrollViewFoundation.frame.height - self.seeImagesBtn.frame.height
            self.changeLargeImg(imageName: self.selectProductImages[self.tempImg], imageView: self.productLargeImgView, currentVC: self)
            
        })
            
            imageRollActive = false
            
        }
    }
    
    //MARK:  Large Product Image View
    let scrollViewFoundation = UIView()
    var productSuper = LargeImgSV()
    var productLargeImgView = UIImageView()
    var productLargeImg: UIImage!
    
    let loveButton = LoveButton()
    let infoButton = InfoButton()
    let addToCartBtn = AddButton()
    let arrowBtn = NextArrow()
    let arrowBtn2 = NextArrow()
    
    var seeImagesBtn: UIButton = {
        let button = UIButton()
        button.setTitle("see all images", for: .normal)
        button.titleLabel?.font = UIFont(name: "futura", size: 15)
        return button
    }()
    
    //MARK:  Setup Large Product Image View
    func setUpLargeImg(){

        self.view.addSubview(scrollViewFoundation)
        scrollViewFoundation.lrgImageContainerSize(currentVC: self, container: scrollViewFoundation, pctHeight: 1, header: 44, statusBar: 20, constant: productDetailCV.CELLSPACING, constantActive: productDetailCV.CELLSPACING)
        
        scrollViewFoundation.addSubview(productSuper)
        productSuper.frame = scrollViewFoundation.bounds
        
    
        productSuper.addSubview(productLargeImgView)
        changeLargeImg(imageName: selectProductImages[(jewelryOptions?.count)! - 1], imageView: productLargeImgView, currentVC: self)
        
        
        loveButton.loveButtonConstraints(superview: scrollViewFoundation,
                                         applyToObject: loveButton)
        
        infoButton.setUpInfoBtn(container: scrollViewFoundation, applyToView: infoButton)
        infoButton.addTarget(self, action: #selector(self.displayInfo), for: .touchUpInside)
        
        
        addToCartBtn.setUpAddButton(container: scrollViewFoundation, applyToView: addToCartBtn, vc: self)
        
        scrollViewFoundation.addSubview(seeImagesBtn)
        seeImagesBtn.frame = CGRect(x: scrollViewFoundation.center.x - (scrollViewFoundation.frame.width * 0.35)/2, y: scrollViewFoundation.frame.height - (scrollViewFoundation.frame.height * 0.05), width: (scrollViewFoundation.frame.width * 0.35), height: (scrollViewFoundation.frame.height * 0.05))
        
        seeImagesBtn.addTarget(self, action: #selector(self.revealImages), for: .touchUpInside)
        
        arrowBtn.setUpArrow(direction: arrowBtn.leftArrow, container: scrollViewFoundation, applyToView: arrowBtn)
        arrowBtn.tag = 1
        arrowBtn.addTarget(self, action: #selector(self.nextImage(sender:)), for: .touchUpInside)
        
        arrowBtn2.setUpArrow(direction: arrowBtn2.rightArrow, container: scrollViewFoundation, applyToView: arrowBtn2)
        arrowBtn2.tag = 2
        arrowBtn2.addTarget(self, action: #selector(self.nextImage(sender:)), for: .touchUpInside)
    }
    
    func nextImage(sender: UIButton) {
        if sender.tag == 1 {
            if tempImg == 0 {
                // do nothing
            } else {
                tempImg -= 1
            }
        } else if sender.tag == 2 {
            if tempImg == selectProductImages.count - 1  {
                // do nothing
            } else {
                tempImg += 1
            }
        }
    }
    
    let infoTV = ProductInfoTV()
    
    func displayInfo(){

        infoTV.setUpInfoTV(viewAddedTo: self)
    }
    
    var tempImg: Int = 0 {
        didSet{
            changeLargeImg(imageName: selectProductImages[tempImg], imageView: productLargeImgView, currentVC: self)
            print(tempImg)
        }
    }
    
    func changeLargeImg(imageName: String, imageView: UIImageView, currentVC: ProductVC){
        
        productLargeImg = UIImage(named: imageName)
        imageView.image = productLargeImg
        
        let widthScale = productSuper.frame.width/productLargeImg.size.width
        let heightScale = productSuper.frame.height/productLargeImg.size.height
        
        productSuper.zoomScale = 1.0
        
        if productLargeImg.size.width < productLargeImg.size.height {
            imageView.frame = CGRect(x: 0, y: 0, width: widthScale * productLargeImg.size.width, height: widthScale * productLargeImg.size.height)
            productSuper.largeImgSVSetUp(imageView: imageView, image: productLargeImg, currentVC: currentVC)
            productSuper.contentOffset = CGPoint(x: 0, y: (productSuper.contentSize.height-productSuper.frame.height)/2)
        } else {
            imageView.frame = CGRect(x: 0, y: 0, width: heightScale * productLargeImg.size.width, height: heightScale * productLargeImg.size.height)
            productSuper.largeImgSVSetUp(imageView: imageView, image: productLargeImg, currentVC: currentVC)
            productSuper.contentOffset = CGPoint(x: (productSuper.contentSize.width-productSuper.frame.width)/2, y: 0)
        }
    }
    
    
    func checkFavoriteStatus(product: Product){
        
        loveButton.selectedProduct = product
        addToCartBtn.selectedProduct = product
        
        if product.favorite {
            loveButton.selectLoveButtonOn()
        } else {
            loveButton.selectLoveButtonOff()
        }

    }
    
}
